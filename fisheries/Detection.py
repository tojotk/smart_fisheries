# import cv2
# import torch
# import numpy as np
# from transformers import DetrImageProcessor, DetrForObjectDetection
# from PIL import Image
#
# # ---------------- Load Object Detector ----------------
# processor = DetrImageProcessor.from_pretrained("facebook/detr-resnet-50")
# model = DetrForObjectDetection.from_pretrained("facebook/detr-resnet-50")
# model.eval()
#
# cap = cv2.VideoCapture(0)
#
# # ---------------- Water Detection ----------------
# def detect_water(frame):
#     hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)
#
#     lower_blue = np.array([90, 40, 40])
#     upper_blue = np.array([140, 255, 255])
#
#     mask = cv2.inRange(hsv, lower_blue, upper_blue)
#     mask = cv2.medianBlur(mask, 7)
#     return mask
#
# # ---------------- Simple IoU Tracking ----------------
# def iou(box1, box2):
#     x1 = max(box1[0], box2[0])
#     y1 = max(box1[1], box2[1])
#     x2 = min(box1[2], box2[2])
#     y2 = min(box1[3], box2[3])
#
#     inter = max(0, x2 - x1) * max(0, y2 - y1)
#     area1 = (box1[2] - box1[0]) * (box1[3] - box1[1])
#     area2 = (box2[2] - box2[0]) * (box2[3] - box2[1])
#
#     return inter / (area1 + area2 - inter + 1e-6)
#
# # ---------------- Tracking Data ----------------
# tracks = {}
# next_id = 0
#
# # FRAME_THRESHOLD = 3
# # WATER_RATIO_THRESHOLD = 0.45
# # IOU_THRESHOLD = 0.4
# FRAME_THRESHOLD = 3
# WATER_RATIO_THRESHOLD = 0.35
# IOU_THRESHOLD = 0.3
# import requests
# # ---------------- Main Loop ----------------
# while cap.isOpened():
#     ret, frame = cap.read()
#     # frame=cv2.imread("xxx.jpg")
#     if not ret:
#         break
#     cv2.imwrite("sample.png",frame)
#     water_mask = detect_water(frame)
#
#     image = Image.fromarray(cv2.cvtColor(frame, cv2.COLOR_BGR2RGB))
#     inputs = processor(images=image, return_tensors="pt")
#
#     with torch.no_grad():
#         outputs = model(**inputs)
#
#     target_sizes = torch.tensor([image.size[::-1]])
#     results = processor.post_process_object_detection(
#         outputs, threshold=0.7, target_sizes=target_sizes
#     )[0]
#
#     new_tracks = {}
#
#     for score, label, box in zip(results["scores"], results["labels"], results["boxes"]):
#         cls = model.config.id2label[label.item()]
#         if cls not in ["person", "boat"]:
#             continue
#
#         x1, y1, x2, y2 = map(int, box.tolist())
#
#         # Track matching
#         matched_id = None
#         for tid, t in tracks.items():
#             if iou(t["box"], (x1, y1, x2, y2)) > IOU_THRESHOLD:
#                 matched_id = tid
#                 break
#
#         if matched_id is None:
#             matched_id = next_id
#             next_id += 1
#             sink_frames = 0
#         else:
#             sink_frames = tracks[matched_id]["sink_frames"]
#
#         roi = water_mask[y1:y2, x1:x2]
#         if roi.size == 0:
#             continue
#
#         water_ratio = np.count_nonzero(roi) / roi.size
#
#         # Temporal sinking decision
#         if water_ratio > WATER_RATIO_THRESHOLD:
#             sink_frames += 1
#         else:
#             sink_frames = max(0, sink_frames - 1)
#
#         status = "SINKING" if sink_frames > FRAME_THRESHOLD else "SAFE"
#         color = (0, 0, 255) if status == "SINKING" else (0, 255, 0)
#
#         new_tracks[matched_id] = {
#             "box": (x1, y1, x2, y2),
#             "sink_frames": sink_frames
#         }
#
#         cv2.rectangle(frame, (x1, y1), (x2, y2), color, 2)
#         cv2.putText(
#             frame,
#             f"{cls.upper()} - {status}",
#             (x1, y1 - 10),
#             cv2.FONT_HERSHEY_SIMPLEX,
#             0.6,
#             color,
#             2
#         )
#         if status=="SINKING":
#         # if True:
#
#
#             url = "http://localhost:8000/myapp/drowning_detction_fn/"
#
#             with open("sample.png", "rb") as f:
#                 files = {"image": f}
#                 data = {
#                     "bid": str(7)  # <-- ID sent here
#                 }
#
#                 response = requests.post(
#                     url,
#                     files=files,
#                     data=data
#                 )
#
#
#     tracks = new_tracks
#
#     cv2.imshow("Person / Boat Sink Detection", frame)
#     if cv2.waitKey(1) & 0xFF == ord("q"):
#         break
#
# cap.release()
# cv2.destroyAllWindows()







#
#
# import cv2
# import numpy as np
# from threading import Thread
# import queue
#
# # ---------------- Load Lightweight Object Detector ----------------
# from ultralytics import YOLO
#
# print("Loading YOLOv8 model...")
# model = YOLO('yolov8n.pt')  # nano model - fastest option
# print("Model loaded successfully")
#
# cap = cv2.VideoCapture(0)
# # Lower resolution for speed
# cap.set(cv2.CAP_PROP_FRAME_WIDTH, 640)
# cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 480)
# cap.set(cv2.CAP_PROP_BUFFERSIZE, 1)  # Reduce buffer to get latest frames
#
#
# # ---------------- Water Detection ----------------
# def detect_water(frame):
#     hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)
#
#     # More restrictive water detection - higher saturation and specific blue range
#     lower_blue = np.array([100, 80, 80])  # Increased saturation to avoid clothes
#     upper_blue = np.array([130, 255, 255])  # Narrower hue range for water
#
#     mask = cv2.inRange(hsv, lower_blue, upper_blue)
#
#     # More aggressive filtering to remove small patches (like clothing)
#     kernel = np.ones((5, 5), np.uint8)
#     mask = cv2.morphologyEx(mask, cv2.MORPH_OPEN, kernel)  # Remove small noise
#     mask = cv2.morphologyEx(mask, cv2.MORPH_CLOSE, kernel)  # Fill small holes
#     mask = cv2.medianBlur(mask, 9)
#
#     return mask
#
#
# # ---------------- Simple IoU Tracking ----------------
# def iou(box1, box2):
#     x1 = max(box1[0], box2[0])
#     y1 = max(box1[1], box2[1])
#     x2 = min(box1[2], box2[2])
#     y2 = min(box1[3], box2[3])
#
#     inter = max(0, x2 - x1) * max(0, y2 - y1)
#     area1 = (box1[2] - box1[0]) * (box1[3] - box1[1])
#     area2 = (box2[2] - box2[0]) * (box2[3] - box2[1])
#
#     return inter / (area1 + area2 - inter + 1e-6)
#
#
# # ---------------- Async Alert System ----------------
# alert_queue = queue.Queue()
#
#
# def alert_worker():
#     """Background thread for sending alerts without blocking main loop"""
#     import requests
#     while True:
#         try:
#             frame_data = alert_queue.get(timeout=1)
#             if frame_data is None:
#                 break
#
#             frame, bid = frame_data
#             _, buffer = cv2.imencode('.png', frame)
#
#             url = "http://localhost:8000/myapp/drowning_detction_fn/"
#
#             try:
#                 files = {"image": ("sample.png", buffer.tobytes(), "image/png")}
#                 data = {"bid": str(bid)}
#                 response = requests.post(url, files=files, data=data, timeout=5)
#             except Exception as e:
#                 print(f"Alert send error: {e}")
#
#             alert_queue.task_done()
#         except queue.Empty:
#             continue
#
#
# alert_thread = Thread(target=alert_worker, daemon=True)
# alert_thread.start()
#
# # ---------------- Tracking Data ----------------
# tracks = {}
# next_id = 0
#
# FRAME_THRESHOLD = 3
# WATER_RATIO_THRESHOLD = 0.50  # Increased to require more water coverage (50% instead of 35%)
# IOU_THRESHOLD = 0.5  # Increased for better tracking stability
# SKIP_FRAMES = 2  # Process every 2nd frame
#
# frame_count = 0
# last_boxes = []
#
# # COCO class IDs: person=0, boat=8
# TARGET_CLASSES = [0, 8]
#
# # ---------------- Main Loop ----------------
# print("Starting camera... Press 'q' to quit")
#
# while cap.isOpened():
#     ret, frame = cap.read()
#     if not ret:
#         break
#
#     frame_count += 1
#
#     # Only run detection every SKIP_FRAMES frames
#     if frame_count % SKIP_FRAMES == 0:
#         # YOLOv8 inference with higher confidence and IOU for better accuracy
#         results = model(frame, verbose=False, conf=0.6, iou=0.45)
#
#         # Extract boxes for person and boat
#         boxes_data = []
#         for result in results:
#             boxes = result.boxes
#             for i in range(len(boxes)):
#                 cls_id = int(boxes.cls[i])
#                 if cls_id in TARGET_CLASSES:
#                     x1, y1, x2, y2 = boxes.xyxy[i].cpu().numpy()
#                     conf = float(boxes.conf[i])
#                     cls_name = 'person' if cls_id == 0 else 'boat'
#                     boxes_data.append({
#                         'box': (int(x1), int(y1), int(x2), int(y2)),
#                         'class': cls_name,
#                         'conf': conf
#                     })
#
#         last_boxes = boxes_data
#         water_mask = detect_water(frame)
#     else:
#         # Reuse last detections
#         boxes_data = last_boxes
#         water_mask = None
#
#     new_tracks = {}
#
#     for detection in boxes_data:
#         x1, y1, x2, y2 = detection['box']
#         cls = detection['class']
#
#         # Track matching
#         matched_id = None
#         for tid, t in tracks.items():
#             if iou(t["box"], (x1, y1, x2, y2)) > IOU_THRESHOLD:
#                 matched_id = tid
#                 break
#
#         if matched_id is None:
#             matched_id = next_id
#             next_id += 1
#             sink_frames = 0
#             smoothed_box = (x1, y1, x2, y2)
#         else:
#             sink_frames = tracks[matched_id]["sink_frames"]
#             # Smooth box position with previous box (80% current, 20% previous)
#             prev_box = tracks[matched_id]["box"]
#             smoothed_box = (
#                 int(0.8 * x1 + 0.2 * prev_box[0]),
#                 int(0.8 * y1 + 0.2 * prev_box[1]),
#                 int(0.8 * x2 + 0.2 * prev_box[2]),
#                 int(0.8 * y2 + 0.2 * prev_box[3])
#             )
#             x1, y1, x2, y2 = smoothed_box
#
#         # Only calculate water ratio on detection frames
#         if water_mask is not None and frame_count % SKIP_FRAMES == 0:
#             roi = water_mask[y1:y2, x1:x2]
#             if roi.size > 0:
#                 water_ratio = np.count_nonzero(roi) / roi.size
#
#                 # Additional check: is there significant water in the surrounding area?
#                 # Check if bottom 1/3 of frame has water (person should be IN water, not just wearing blue)
#                 frame_height = frame.shape[0]
#                 lower_frame = water_mask[int(frame_height * 0.66):, :]
#                 surrounding_water_ratio = np.count_nonzero(
#                     lower_frame) / lower_frame.size if lower_frame.size > 0 else 0
#
#                 # Only trigger if BOTH: person has blue/green AND there's water in environment
#                 has_water_context = surrounding_water_ratio > 0.15
#
#                 # Temporal sinking decision
#                 if water_ratio > WATER_RATIO_THRESHOLD and has_water_context:
#                     sink_frames += 1
#                 else:
#                     sink_frames = max(0, sink_frames - 1)
#
#         status = "SINKING" if sink_frames > FRAME_THRESHOLD else "SAFE"
#         color = (0, 0, 255) if status == "SINKING" else (0, 255, 0)
#
#         new_tracks[matched_id] = {
#             "box": (x1, y1, x2, y2),
#             "sink_frames": sink_frames
#         }
#
#         cv2.rectangle(frame, (x1, y1), (x2, y2), color, 2)
#         cv2.putText(
#             frame,
#             f"{cls.upper()} - {status}",
#             (x1, y1 - 10),
#             cv2.FONT_HERSHEY_SIMPLEX,
#             0.6,
#             color,
#             2
#         )
#
#         if status == "SINKING":
#             if alert_queue.qsize() < 5:
#                 alert_queue.put((frame.copy(), 7))
#
#     tracks = new_tracks
#
#     cv2.imshow("Person / Boat Sink Detection", frame)
#     if cv2.waitKey(1) & 0xFF == ord("q"):
#         break
#
# # Cleanup
# alert_queue.put(None)
# alert_thread.join(timeout=2)
# cap.release()
# cv2.destroyAllWindows()









import cv2
import numpy as np
from threading import Thread
import queue
import requests

# ---------------- Load Lightweight Object Detector ----------------
from ultralytics import YOLO

print("Loading YOLOv8 model...")
model = YOLO('yolov8n.pt')  # nano model - fastest option
print("Model loaded successfully")

cap = cv2.VideoCapture(0)
# Lower resolution for speed
cap.set(cv2.CAP_PROP_FRAME_WIDTH, 640)
cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 480)
cap.set(cv2.CAP_PROP_BUFFERSIZE, 1)


# ---------------- Location Detection ----------------
def get_current_location():
    """Get current GPS coordinates"""
    try:
        # Try to get location from IP-based geolocation API
        response = requests.get('http://ip-api.com/json/', timeout=3)
        if response.status_code == 200:
            data = response.json()
            return {
                'latitude': data.get('lat', 0.0),
                'longitude': data.get('lon', 0.0)
            }
    except Exception as e:
        print(f"Location fetch error: {e}")

    # Default fallback coordinates
    return {'latitude': 0.0, 'longitude': 0.0}


# ---------------- Water Detection ----------------
def detect_water(frame):
    hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)

    lower_blue = np.array([100, 80, 80])
    upper_blue = np.array([130, 255, 255])

    mask = cv2.inRange(hsv, lower_blue, upper_blue)

    kernel = np.ones((5, 5), np.uint8)
    mask = cv2.morphologyEx(mask, cv2.MORPH_OPEN, kernel)
    mask = cv2.morphologyEx(mask, cv2.MORPH_CLOSE, kernel)
    mask = cv2.medianBlur(mask, 9)

    return mask


# ---------------- Simple IoU Tracking ----------------
def iou(box1, box2):
    x1 = max(box1[0], box2[0])
    y1 = max(box1[1], box2[1])
    x2 = min(box1[2], box2[2])
    y2 = min(box1[3], box2[3])

    inter = max(0, x2 - x1) * max(0, y2 - y1)
    area1 = (box1[2] - box1[0]) * (box1[3] - box1[1])
    area2 = (box2[2] - box2[0]) * (box2[3] - box2[1])

    return inter / (area1 + area2 - inter + 1e-6)


# ---------------- Async Alert System ----------------
alert_queue = queue.Queue()
boat_alert_queue = queue.Queue()


def alert_worker():
    """Background thread for sending drowning alerts"""
    while True:
        try:
            alert_data = alert_queue.get(timeout=1)
            if alert_data is None:
                break

            frame, bid = alert_data
            _, buffer = cv2.imencode('.png', frame)

            # Get current location
            location = get_current_location()

            url = "http://localhost:8000/myapp/drowning_detction_fn/"

            try:
                files = {"image": ("sample.png", buffer.tobytes(), "image/png")}
                data = {
                    "bid": str(bid),
                    "latitude": str(location['latitude']),
                    "longitude": str(location['longitude'])
                }
                response = requests.post(url, files=files, data=data, timeout=5)
                print(f"Drowning alert sent for bid {bid} at ({location['latitude']}, {location['longitude']})")
            except Exception as e:
                print(f"Drowning alert error: {e}")

            alert_queue.task_done()
        except queue.Empty:
            continue


def boat_alert_worker():
    """Background thread for sending boat/trolling violation alerts"""
    while True:
        try:
            alert_data = boat_alert_queue.get(timeout=1)
            if alert_data is None:
                break

            frame, detection_type = alert_data
            _, buffer = cv2.imencode('.png', frame)

            # Get current location
            location = get_current_location()

            url = "http://localhost:8000/myapp/TrollingDetection/"

            try:
                files = {"image": ("boat_detection.png", buffer.tobytes(), "image/png")}
                data = {
                    "detection_type": detection_type,
                    "latitude": str(location['latitude']),
                    "longitude": str(location['longitude'])
                }
                response = requests.post(url, files=files, data=data, timeout=5)
                print(f"Boat alert sent: {detection_type} at ({location['latitude']}, {location['longitude']})")
            except Exception as e:
                print(f"Boat alert error: {e}")

            boat_alert_queue.task_done()
        except queue.Empty:
            continue


# Start alert threads
alert_thread = Thread(target=alert_worker, daemon=True)
alert_thread.start()

boat_alert_thread = Thread(target=boat_alert_worker, daemon=True)
boat_alert_thread.start()

# ---------------- Tracking Data ----------------
tracks = {}
next_id = 0

FRAME_THRESHOLD = 2
WATER_RATIO_THRESHOLD = 0.45
IOU_THRESHOLD = 0.5
SKIP_FRAMES = 2

frame_count = 0
last_boxes = []

# COCO class IDs: person=0, boat=8
TARGET_CLASSES = [0, 8]

# Boat detection tracking
last_boat_alert_time = 0
BOAT_ALERT_COOLDOWN = 30  # seconds between boat alerts

# ---------------- Main Loop ----------------
print("Starting camera... Press 'q' to quit")

import time

while cap.isOpened():
    ret, frame = cap.read()
    if not ret:
        break

    frame_count += 1

    # Only run detection every SKIP_FRAMES frames
    if frame_count % SKIP_FRAMES == 0:
        results = model(frame, verbose=False, conf=0.6, iou=0.45)

        # Extract boxes for person and boat
        boxes_data = []
        boat_detected = False

        for result in results:
            boxes = result.boxes
            for i in range(len(boxes)):
                cls_id = int(boxes.cls[i])
                if cls_id in TARGET_CLASSES:
                    x1, y1, x2, y2 = boxes.xyxy[i].cpu().numpy()
                    conf = float(boxes.conf[i])
                    cls_name = 'person' if cls_id == 0 else 'boat'

                    boxes_data.append({
                        'box': (int(x1), int(y1), int(x2), int(y2)),
                        'class': cls_name,
                        'conf': conf
                    })

                    if cls_name == 'boat':
                        boat_detected = True

        # Check for boat in trolling area
        if boat_detected:
            current_time = time.time()
            if current_time - last_boat_alert_time > BOAT_ALERT_COOLDOWN:
                if boat_alert_queue.qsize() < 3:
                    boat_alert_queue.put((frame.copy(), "boat_detected"))
                    last_boat_alert_time = current_time

        last_boxes = boxes_data
        water_mask = detect_water(frame)
    else:
        boxes_data = last_boxes
        water_mask = None

    new_tracks = {}

    for detection in boxes_data:
        x1, y1, x2, y2 = detection['box']
        cls = detection['class']

        # Track matching
        matched_id = None
        for tid, t in tracks.items():
            if iou(t["box"], (x1, y1, x2, y2)) > IOU_THRESHOLD:
                matched_id = tid
                break

        if matched_id is None:
            matched_id = next_id
            next_id += 1
            sink_frames = 0
            smoothed_box = (x1, y1, x2, y2)
        else:
            sink_frames = tracks[matched_id]["sink_frames"]
            prev_box = tracks[matched_id]["box"]
            smoothed_box = (
                int(0.8 * x1 + 0.2 * prev_box[0]),
                int(0.8 * y1 + 0.2 * prev_box[1]),
                int(0.8 * x2 + 0.2 * prev_box[2]),
                int(0.8 * y2 + 0.2 * prev_box[3])
            )
            x1, y1, x2, y2 = smoothed_box

        water_ratio = 0
        has_water_context = False

        if cls == 'person' and water_mask is not None and frame_count % SKIP_FRAMES == 0:
            roi = water_mask[y1:y2, x1:x2]
            if roi.size > 0:
                water_ratio = np.count_nonzero(roi) / roi.size

                frame_height = frame.shape[0]
                lower_frame = water_mask[int(frame_height * 0.66):, :]
                surrounding_water_ratio = np.count_nonzero(
                    lower_frame) / lower_frame.size if lower_frame.size > 0 else 0
                has_water_context = surrounding_water_ratio > 0.15

                if water_ratio > WATER_RATIO_THRESHOLD and has_water_context:
                    sink_frames += 1
                else:
                    sink_frames = max(0, sink_frames - 1)

        status = "SINKING" if sink_frames > FRAME_THRESHOLD else "SAFE"

        if cls == 'boat':
            status = "BOAT DETECTED"
            color = (255, 165, 0)  # Orange for boats
        else:
            color = (0, 0, 255) if status == "SINKING" else (0, 255, 0)

        new_tracks[matched_id] = {
            "box": (x1, y1, x2, y2),
            "sink_frames": sink_frames
        }

        cv2.rectangle(frame, (x1, y1), (x2, y2), color, 2)

        debug_text = f"{cls.upper()} - {status}"
        if cls == 'person':
            debug_text += f" (W:{water_ratio:.2f} F:{sink_frames})"

        cv2.putText(
            frame,
            debug_text,
            (x1, y1 - 10),
            cv2.FONT_HERSHEY_SIMPLEX,
            0.5,
            color,
            2
        )

        if status == "SINKING" and cls == 'person':
            if alert_queue.qsize() < 5:
                alert_queue.put((frame.copy(), 19))

    tracks = new_tracks

    cv2.imshow("Person / Boat Sink Detection", frame)
    if cv2.waitKey(1) & 0xFF == ord("q"):
        break

# Cleanup
alert_queue.put(None)
boat_alert_queue.put(None)
alert_thread.join(timeout=2)
boat_alert_thread.join(timeout=2)
cap.release()
cv2.destroyAllWindows()