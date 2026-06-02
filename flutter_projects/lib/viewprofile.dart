// import 'dart:convert';
// import 'dart:io';
// // import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:url_launcher/url_launcher.dart';
//
//
//
// class Profile extends StatefulWidget {
//   const Profile({super.key});
//
//   @override
//   State<Profile> createState() => _ProfileState();
// }
//
// class _ProfileState extends State<Profile> {
//   Map<String, dynamic>? profileData;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchStudentDetails();
//   }
//
//   Future<void> fetchStudentDetails() async {
//     final prefs = await SharedPreferences.getInstance();
//     String? lid = prefs.getString("lid");
//     String? baseUrl = prefs.getString("url");
//     String? imgBaseUrl = prefs.getString("img_url");
//
//     if (lid == null || baseUrl == null || imgBaseUrl == null) return;
//
//     final url = Uri.parse('$baseUrl/view_profile/');
//     final response = await http.post(url, body: {'lid': lid});
//
//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       if (data['status'] == 'ok') {
//         data['data']['photo'] = imgBaseUrl + data['data']['photo'];
//         setState(() {
//           profileData = data['data'];
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               const Color(0xFF35577D),
//               const Color(0xFF35577D).withOpacity(0.7),
//               const Color(0xFF35577D),
//             ],
//             stops: const [0.0, 0.4, 0.8],
//           ),
//         ),
//         child: SafeArea(
//           child: profileData == null
//               ? const Center(child: CircularProgressIndicator(color: Color(0xFF40C4FF)))
//               : SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//             child: Column(
//               children: [
//                 // Profile Header
//                 Container(
//                   padding: const EdgeInsets.all(24),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.05),
//                         blurRadius: 20,
//                         offset: const Offset(0, 8),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       CircleAvatar(
//                         radius: 60,
//                         backgroundColor: const Color(0xFF35577D).withOpacity(0.1),
//                         child: CircleAvatar(
//                           radius: 56,
//                           backgroundImage: NetworkImage(profileData!['photo']),
//                           backgroundColor: Colors.grey[300],
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       Text(
//                         profileData!['name'],
//                         style: const TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF35577D),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         profileData!['email'],
//                         style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                       ),
//                       const SizedBox(height: 16),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.phone,
//                             color: const Color(0xFF35577D).withOpacity(0.8),
//                             size: 24,
//                           ),
//                           const SizedBox(width: 8),
//                           Text(
//                             profileData!['dob'],
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xFF35577D),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 // Profile Details
//                 Container(
//                   padding: const EdgeInsets.all(24),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.white.withOpacity(0.05),
//                         blurRadius: 20,
//                         offset: const Offset(0, 8),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Profile Details",
//                         style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF35577D),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         "Your personal information",
//                         style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                       ),
//                       const SizedBox(height: 16),
//                       buildInfoCard(Icons.person_rounded, 'Name', profileData!['name']),
//                       buildInfoCard(Icons.email_rounded, 'Email', profileData!['email']),
//                       buildInfoCard(Icons.calendar_today, 'Date of Birth', profileData!['dob']),
//                       buildInfoCard(Icons.phone_rounded, 'Phone', profileData!['phone']),
//                       buildInfoCard(Icons.location_city_rounded, 'Place', profileData!['place']),
//
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF35577D),
//                       foregroundColor: Colors.white,),
//                       onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => const UpdateProfile()),
//                       );
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: const [
//                         Text(
//                           "Update Profile",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             letterSpacing: 0.5,
//                           ),
//                         ),
//                         SizedBox(width: 8),
//                         Icon(Icons.edit_rounded, size: 20),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Container(
//                   padding: const EdgeInsets.all(14),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.95),
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(
//                       color: const Color(0xFF35577D).withOpacity(0.3),
//                       width: 1,
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.info_outline_rounded,
//                         color: const Color(0xFF35577D),
//                         size: 20,
//                       ),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: Text(
//                           "Keep your profile updated!!",
//                           style: TextStyle(fontSize: 13, color: Colors.grey[700]),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildInfoCard(IconData icon, String label, String value) {
//     return Card(
//       elevation: 0,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: ListTile(
//         leading: Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: const Color(0xFF35577D).withOpacity(0.1),
//             // color: const Color(0xFF35577D).withOpacity(0.1),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(icon, color: const Color(0xFF35577D)),
//         ),
//         title: Text(
//           label,
//           style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF35577D)),
//         ),
//         subtitle: Text(
//           value,
//           style: TextStyle(fontSize: 15, color: Colors.grey[700]),
//         ),
//       ),
//     );
//   }
// }
//
// class UpdateProfile extends StatefulWidget {
//   const UpdateProfile({super.key});
//
//   @override
//   State<UpdateProfile> createState() => _UpdateProfileState();
// }
//
// class _UpdateProfileState extends State<UpdateProfile> {
//   Map<String, dynamic>? profileData;
//   File? _photo;
//   File? _resume;
//   final ImagePicker _imagePicker = ImagePicker();
//   // final FilePicker _filePicker = FilePicker.platform;
//
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//
//   final TextEditingController phoneController = TextEditingController();
//
//   final TextEditingController placeController = TextEditingController();
//
//
//   @override
//   void initState() {
//     super.initState();
//     fetchStudentDetails();
//   }
//
//   Future<void> fetchStudentDetails() async {
//     final prefs = await SharedPreferences.getInstance();
//     String? lid = prefs.getString("lid");
//     String? baseUrl = prefs.getString("url");
//     String? imgBaseUrl = prefs.getString("img_url");
//
//     if (lid == null || baseUrl == null) return;
//
//     final url = Uri.parse('$baseUrl/view_profile/');
//     final response = await http.post(url, body: {'lid': lid});
//
//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       if (data['status'] == 'ok') {
//         data['data']['photo'] = imgBaseUrl! + data['data']['photo'];
//         setState(() {
//           profileData = data['data'];
//           nameController.text = data['data']['name'];
//           emailController.text = data['data']['email'];
//           phoneController.text = data['data']['phone'];
//           placeController.text = data['data']['place'];
//         });
//       }
//     }
//   }
//
//   Future<void> _pickFile(ImageSource source, bool isPhoto) async {
//     if (isPhoto) {
//       final pickedFile = await _imagePicker.pickImage(source: source);
//       if (pickedFile != null) {
//         setState(() {
//           _photo = File(pickedFile.path);
//         });
//       }
//     }
//   }
//
//   // Future<void> _pickResume() async {
//   //   final result = await _filePicker.pickFiles(
//   //     type: FileType.custom,
//   //     allowedExtensions: ['pdf', 'doc', 'docx'],
//   //   );
//   //   if (result != null && result.files.isNotEmpty) {
//   //     setState(() {
//   //       _resume = File(result.files.single.path!);
//   //     });
//   //   } else {
//   //     Fluttertoast.showToast(
//   //       msg: "No file selected",
//   //       backgroundColor: Colors.red[400],
//   //       textColor: Colors.white,
//   //     );
//   //   }
//   // }
//
//   Future<void> sendData() async {
//     final prefs = await SharedPreferences.getInstance();
//     String? url = prefs.getString('url');
//     String? lid = prefs.getString('lid');
//
//     if (nameController.text.isEmpty ||
//         emailController.text.isEmpty ||
//         phoneController.text.isEmpty) {
//       Fluttertoast.showToast(
//         msg: "Please fill all required fields",
//         backgroundColor: Colors.red[400],
//         textColor: Colors.white,
//       );
//       return;
//     }
//
//     final api = Uri.parse('$url/UpdateProfile/');
//     try {
//       final request = http.MultipartRequest('POST', api);
//       request.fields.addAll({
//         'lid': lid ?? '',
//         'name': nameController.text,
//         'email': emailController.text,
//
//         'phone': phoneController.text,
//
//         'place': placeController.text,
//
//       });
//
//       if (_photo != null) {
//         request.files.add(await http.MultipartFile.fromPath('photo', _photo!.path));
//       }
//
//
//       final response = await request.send();
//
//       if (response.statusCode == 200) {
//         final respData = jsonDecode(await response.stream.bytesToString());
//         if (respData['status'] == 'ok') {
//           Fluttertoast.showToast(
//             msg: "Profile updated successfully",
//             backgroundColor: Colors.green[400],
//             textColor: Colors.white,
//           );
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => const Profile()),
//           );
//         } else {
//           Fluttertoast.showToast(
//             msg: "Update failed",
//             backgroundColor: Colors.red[400],
//             textColor: Colors.white,
//           );
//         }
//       } else {
//         Fluttertoast.showToast(
//           msg: "Server error",
//           backgroundColor: Colors.red[400],
//           textColor: Colors.white,
//         );
//       }
//     } catch (e) {
//       Fluttertoast.showToast(
//         msg: "Error: $e",
//         backgroundColor: Colors.red[400],
//         textColor: Colors.white,
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               const Color(0xFF35577D),
//               const Color(0xFF35577D).withOpacity(0.7),
//               const Color(0xFF35577D),
//             ],
//             stops: const [0.0, 0.4, 0.8],
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Header
//                 Container(
//                   padding: const EdgeInsets.all(24),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.white.withOpacity(0.05),
//                         blurRadius: 20,
//                         offset: const Offset(0, 8),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           const Text(
//                             "Update Profile",
//                             style: TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xFF35577D),
//                             ),
//                           ),
//                           const Spacer(),
//                           Icon(
//                             Icons.bolt,
//                             color: const Color(0xFF35577D).withOpacity(0.8),
//                             size: 24,
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         "Update your details to keep your profile current",
//                         style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 // Form
//                 Container(
//                   padding: const EdgeInsets.all(24),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.05),
//                         blurRadius: 20,
//                         offset: const Offset(0, 8),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       TextFormField(
//                         controller: nameController,
//                         style: const TextStyle(fontSize: 16),
//                         decoration: const InputDecoration(
//                           labelText: 'Name',
//                           hintText: 'Enter your full name',
//                           prefixIcon: Icon(Icons.person_rounded, color: Color(0xFF35577D)),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       TextFormField(
//                         controller: emailController,
//                         style: const TextStyle(fontSize: 16),
//                         decoration: const InputDecoration(
//                           labelText: 'Email',
//                           hintText: 'Enter your email',
//                           prefixIcon: Icon(Icons.email_rounded, color: Color(0xFF35577D)),
//                         ),
//                         keyboardType: TextInputType.emailAddress,
//                       ),
//
//                       const SizedBox(height: 16),
//
//                       TextFormField(
//                         controller: phoneController,
//                         style: const TextStyle(fontSize: 16),
//                         decoration: const InputDecoration(
//                           labelText: 'Phone',
//                           hintText: 'Enter your phone number',
//                           prefixIcon: Icon(Icons.phone_rounded, color: Color(0xFF35577D)),
//                         ),
//                         keyboardType: TextInputType.phone,
//                       ),
//
//                       const SizedBox(height: 16),
//                       TextFormField(
//                         controller: placeController,
//                         style: const TextStyle(fontSize: 16),
//                         decoration: const InputDecoration(
//                           labelText: 'Place',
//                           hintText: 'Enter your place',
//                           prefixIcon: Icon(Icons.location_on_rounded, color: Color(0xFF35577D)),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//
//                       const Text(
//                         "Upload Photo",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF35577D),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       _photo == null
//                           ? (profileData != null
//                           ? ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image.network(
//                           profileData!['photo'],
//                           height: 150,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) => Container(
//                             height: 150,
//                             decoration: BoxDecoration(
//                               color: Colors.grey[100],
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: const Center(
//                               child: Text("No photo available", style: TextStyle(color: Colors.grey)),
//                             ),
//                           ),
//                         ),
//                       )
//                           : Container(
//                         height: 150,
//                         decoration: BoxDecoration(
//                           color: Colors.grey[100],
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: const Center(
//                           child: Text("No photo selected", style: TextStyle(color: Colors.grey)),
//                         ),
//                       ))
//                           : ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image.file(_photo!, height: 150, fit: BoxFit.cover),
//                       ),
//                       const SizedBox(height: 12),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Expanded(
//                             child: ElevatedButton.icon(
//                               onPressed: () => _pickFile(ImageSource.gallery, true),
//                               icon: const Icon(Icons.photo, size: 20),
//                               label: const Text("Gallery"),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFF35577D).withOpacity(0.9),
//                                 foregroundColor: Colors.white,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: ElevatedButton.icon(
//                               onPressed: () => _pickFile(ImageSource.camera, true),
//                               icon: const Icon(Icons.camera_alt, size: 20),
//                               label: const Text("Camera"),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFF35577D).withOpacity(0.9),
//                                 foregroundColor: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//
//                       // const SizedBox(height: 12),
//                       // SizedBox(
//                       //   width: double.infinity,
//                       //   child: ElevatedButton.icon(
//                       //     onPressed: _pickResume,
//                       //     icon: const Icon(Icons.file_upload_rounded, size: 20),
//                       //     label: const Text("Pick Resume"),
//                       //   ),
//                       // ),
//                       const SizedBox(height: 20),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF35577D),
//                             foregroundColor: Colors.white,),
//                           onPressed: sendData,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: const [
//                               Text(
//                                 "Update Profile",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w600,
//                                   letterSpacing: 0.5,
//                                 ),
//                               ),
//                               SizedBox(width: 8),
//                               Icon(Icons.check_circle_rounded, size: 20),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 32),
//                 Container(
//                   padding: const EdgeInsets.all(14),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.95),
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(
//                       color: const Color(0xFF35577D).withOpacity(0.3),
//                       width: 1,
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.info_outline_rounded,
//                         color: const Color(0xFF35577D),
//                         size: 20,
//                       ),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: Text(
//                           "Ensure all fields are filled and files are uploaded correctly",
//                           style: TextStyle(fontSize: 13, color: Colors.grey[700]),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//



import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Deep Teal Color Palette
  static const Color deepTeal = Color(0xFF0b3037);
  static const Color tealAccent = Color(0xFF0d4754);
  static const Color tealLight = Color(0xFF156573);
  static const Color tealBright = Color(0xFF1a8599);
  static const Color accentCyan = Color(0xFF2dd4bf);
  static const Color accentGold = Color(0xFFfbbf24);

  Map<String, dynamic>? profileData;


  @override
  void initState() {
    super.initState();
    fetchStudentDetails();
  }

  Future<void> fetchStudentDetails() async {
    final prefs = await SharedPreferences.getInstance();
    String? lid = prefs.getString("lid");
    String? baseUrl = prefs.getString("url");
    String? imgBaseUrl = prefs.getString("img_url");

    if (lid == null || baseUrl == null || imgBaseUrl == null) return;

    final url = Uri.parse('$baseUrl/view_profile/');
    final response = await http.post(url, body: {'lid': lid});

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == 'ok') {
        data['data']['photo'] = imgBaseUrl + data['data']['photo'];
        setState(() {
          profileData = data['data'];
        });
      }
    }
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               const Color(0xFF35577D),
//               const Color(0xFF35577D).withOpacity(0.7),
//               const Color(0xFF35577D),
//             ],
//             stops: const [0.0, 0.4, 0.8],
//           ),
//         ),
//         child: SafeArea(
//           child: profileData == null
//               ? const Center(child: CircularProgressIndicator(color: Colors.white))
//               : SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//             child: Column(
//               children: [
//                 // Profile Header
//                 Container(
//                   padding: const EdgeInsets.all(24),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.05),
//                         blurRadius: 20,
//                         offset: const Offset(0, 8),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       CircleAvatar(
//                         radius: 60,
//                         backgroundColor: const Color(0xFF35577D).withOpacity(0.1),
//                         child: CircleAvatar(
//                           radius: 56,
//                           backgroundImage: NetworkImage(profileData!['photo']),
//                           backgroundColor: Colors.grey[300],
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       Text(
//                         profileData!['name'],
//                         style: const TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF35577D),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         profileData!['email'],
//                         style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                       ),
//                       const SizedBox(height: 16),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.phone,
//                             color: const Color(0xFF35577D).withOpacity(0.8),
//                             size: 24,
//                           ),
//                           const SizedBox(width: 8),
//                           Text(
//                             profileData!['dob'],
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xFF35577D),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 // Profile Details
//                 Container(
//                   padding: const EdgeInsets.all(24),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.white.withOpacity(0.05),
//                         blurRadius: 20,
//                         offset: const Offset(0, 8),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Profile Details",
//                         style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF35577D),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         "Your personal information",
//                         style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                       ),
//                       const SizedBox(height: 16),
//                       buildInfoCard(Icons.person_rounded, 'Name', profileData!['name']),
//                       buildInfoCard(Icons.email_rounded, 'Email', profileData!['email']),
//                       buildInfoCard(Icons.calendar_today, 'Date of Birth', profileData!['dob']),
//                       buildInfoCard(Icons.phone_rounded, 'Phone', profileData!['phone']),
//                       buildInfoCard(Icons.location_city_rounded, 'Place', profileData!['place']),
//
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF35577D),
//                       foregroundColor: Colors.white,),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => const UpdateProfile()),
//                       );
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: const [
//                         Text(
//                           "Update Profile",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             letterSpacing: 0.5,
//                           ),
//                         ),
//                         SizedBox(width: 8),
//                         Icon(Icons.edit_rounded, size: 20),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Container(
//                   padding: const EdgeInsets.all(14),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.95),
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(
//                       color: const Color(0xFF35577D).withOpacity(0.3),
//                       width: 1,
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.info_outline_rounded,
//                         color: const Color(0xFF35577D),
//                         size: 20,
//                       ),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: Text(
//                           "Keep your profile updated!!",
//                           style: TextStyle(fontSize: 13, color: Colors.grey[700]),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildInfoCard(IconData icon, String label, String value) {
//     return Card(
//       elevation: 0,
//       color: Colors.white,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: ListTile(
//         leading: Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: const Color(0xFF35577D).withOpacity(0.1),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(icon, color: const Color(0xFF35577D)),
//         ),
//         title: Text(
//           label,
//           style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF35577D)),
//         ),
//         subtitle: Text(
//           value,
//           style: const TextStyle(fontSize: 15, color: Colors.black87),
//         ),
//       ),
//     );
//   }
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [deepTeal, tealAccent, tealLight],
          ),
        ),
        child: SafeArea(
          child: profileData == null
              ? Center(
            child: CircularProgressIndicator(
              color: accentCyan,
              strokeWidth: 3,
            ),
          )
              : SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Header with Back Button
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: accentCyan.withOpacity(0.3)),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'My Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Profile Card with Photo
                Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.white.withOpacity(0.95)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: deepTeal.withOpacity(0.3),
                        blurRadius: 25,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Profile Photo with Gradient Border
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [accentCyan, tealBright, accentGold],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: accentCyan.withOpacity(0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: CircleAvatar(
                            radius: 65,
                            backgroundImage: NetworkImage(profileData!['photo']),
                            backgroundColor: Colors.grey[200],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        profileData!['name'],
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: deepTeal,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [tealLight.withOpacity(0.15), accentCyan.withOpacity(0.1)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: accentCyan.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.email_outlined, color: tealBright, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              profileData!['email'],
                              style: TextStyle(
                                fontSize: 14,
                                color: deepTeal,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [accentGold.withOpacity(0.15), accentGold.withOpacity(0.1)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: accentGold.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.phone_rounded, color: tealBright, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              profileData!['phone'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: deepTeal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Profile Details Section
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: deepTeal.withOpacity(0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [tealLight, tealBright],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: tealLight.withOpacity(0.4),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(Icons.person_outline, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "Personal Details",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: deepTeal,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Your personal information",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 20),
                      buildInfoCard(Icons.person_rounded, 'Full Name', profileData!['name'], [Color(0xFF0891b2), Color(0xFF06b6d4)]),
                      const SizedBox(height: 12),
                      buildInfoCard(Icons.email_rounded, 'Email Address', profileData!['email'], [Color(0xFF0d7377), Color(0xFF14e6ac)]),
                      const SizedBox(height: 12),
                      buildInfoCard(Icons.cake_rounded, 'Date of Birth', profileData!['dob'], [tealLight, tealBright]),
                      const SizedBox(height: 12),
                      buildInfoCard(Icons.phone_rounded, 'Phone Number', profileData!['phone'], [Color(0xFF0891b2), Color(0xFF2dd4bf)]),
                      const SizedBox(height: 12),
                      buildInfoCard(Icons.location_on_rounded, 'Location', profileData!['place'], [Color(0xFF0d4754), Color(0xFF156573)]),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Update Profile Button
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [tealLight, tealBright],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: tealBright.withOpacity(0.4),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const UpdateProfile()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.edit_rounded, size: 22, color: Colors.white),
                        SizedBox(width: 12),
                        Text(
                          "Update Profile",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Info Banner
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [accentCyan.withOpacity(0.15), accentGold.withOpacity(0.1)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: accentCyan.withOpacity(0.3), width: 1.5),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [accentCyan, tealBright],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.tips_and_updates_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          "Keep your profile updated for better experience!",
                          style: TextStyle(
                            fontSize: 13,
                            color: deepTeal,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoCard(IconData icon, String label, String value, List<Color> gradientColors) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey[50]!, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: deepTeal.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: gradientColors[0].withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                    fontSize: 12,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    color: deepTeal,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class UpdateProfile extends StatefulWidget {
//   const UpdateProfile({super.key});
//
//   @override
//   State<UpdateProfile> createState() => _UpdateProfileState();
// }
//
// class _UpdateProfileState extends State<UpdateProfile> {
//   Map<String, dynamic>? profileData;
//   File? _photo;
//   final ImagePicker _imagePicker = ImagePicker();
//
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController placeController = TextEditingController();
//
//
//   @override
//   void initState() {
//     super.initState();
//     fetchStudentDetails();
//   }
//
//   Future<void> fetchStudentDetails() async {
//     final prefs = await SharedPreferences.getInstance();
//     String? lid = prefs.getString("lid");
//     String? baseUrl = prefs.getString("url");
//     String? imgBaseUrl = prefs.getString("img_url");
//
//     if (lid == null || baseUrl == null) return;
//
//     final url = Uri.parse('$baseUrl/view_profile/');
//     final response = await http.post(url, body: {'lid': lid});
//
//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       if (data['status'] == 'ok') {
//         data['data']['photo'] = imgBaseUrl! + data['data']['photo'];
//         setState(() {
//           profileData = data['data'];
//           nameController.text = data['data']['name'];
//           emailController.text = data['data']['email'];
//           phoneController.text = data['data']['phone'];
//           placeController.text = data['data']['place'];
//         });
//       }
//     }
//   }
//
//   Future<void> _pickFile(ImageSource source, bool isPhoto) async {
//     if (isPhoto) {
//       final pickedFile = await _imagePicker.pickImage(source: source);
//       if (pickedFile != null) {
//         setState(() {
//           _photo = File(pickedFile.path);
//         });
//       }
//     }
//   }
//
//   Future<void> sendData() async {
//     final prefs = await SharedPreferences.getInstance();
//     String? url = prefs.getString('url');
//     String? lid = prefs.getString('lid');
//
//     if (nameController.text.isEmpty ||
//         emailController.text.isEmpty ||
//         phoneController.text.isEmpty) {
//       Fluttertoast.showToast(
//         msg: "Please fill all required fields",
//         backgroundColor: Colors.red[400],
//         textColor: Colors.white,
//       );
//       return;
//     }
//
//     final api = Uri.parse('$url/UpdateProfile/');
//     try {
//       final request = http.MultipartRequest('POST', api);
//       request.fields.addAll({
//         'lid': lid ?? '',
//         'name': nameController.text,
//         'email': emailController.text,
//         'phone': phoneController.text,
//         'place': placeController.text,
//       });
//
//       if (_photo != null) {
//         request.files.add(await http.MultipartFile.fromPath('photo', _photo!.path));
//       }
//
//
//       final response = await request.send();
//
//       if (response.statusCode == 200) {
//         final respData = jsonDecode(await response.stream.bytesToString());
//         if (respData['status'] == 'ok') {
//           Fluttertoast.showToast(
//             msg: "Profile updated successfully",
//             backgroundColor: Colors.green[400],
//             textColor: Colors.white,
//           );
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => const Profile()),
//           );
//         } else {
//           Fluttertoast.showToast(
//             msg: "Update failed",
//             backgroundColor: Colors.red[400],
//             textColor: Colors.white,
//           );
//         }
//       } else {
//         Fluttertoast.showToast(
//           msg: "Server error",
//           backgroundColor: Colors.red[400],
//           textColor: Colors.white,
//         );
//       }
//     } catch (e) {
//       Fluttertoast.showToast(
//         msg: "Error: $e",
//         backgroundColor: Colors.red[400],
//         textColor: Colors.white,
//       );
//     }
//   }
class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  // Deep Teal Color Palette
  static const Color deepTeal = Color(0xFF0b3037);
  static const Color tealAccent = Color(0xFF0d4754);
  static const Color tealLight = Color(0xFF156573);
  static const Color tealBright = Color(0xFF1a8599);
  static const Color accentCyan = Color(0xFF2dd4bf);
  static const Color accentGold = Color(0xFFfbbf24);

  Map<String, dynamic>? profileData;
  File? _photo;
  final ImagePicker _imagePicker = ImagePicker();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController placeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchStudentDetails();
  }

  Future<void> fetchStudentDetails() async {
    final prefs = await SharedPreferences.getInstance();
    String? lid = prefs.getString("lid");
    String? baseUrl = prefs.getString("url");
    String? imgBaseUrl = prefs.getString("img_url");

    if (lid == null || baseUrl == null) return;

    final url = Uri.parse('$baseUrl/view_profile/');
    final response = await http.post(url, body: {'lid': lid});

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == 'ok') {
        data['data']['photo'] = imgBaseUrl! + data['data']['photo'];
        setState(() {
          profileData = data['data'];
          nameController.text = data['data']['name'];
          emailController.text = data['data']['email'];
          phoneController.text = data['data']['phone'];
          placeController.text = data['data']['place'];
        });
      }
    }
  }

  Future<void> _pickFile(ImageSource source, bool isPhoto) async {
    if (isPhoto) {
      final pickedFile = await _imagePicker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _photo = File(pickedFile.path);
        });
      }
    }
  }

  Future<void> sendData() async {
    final prefs = await SharedPreferences.getInstance();
    String? url = prefs.getString('url');
    String? lid = prefs.getString('lid');

    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please fill all required fields",
        backgroundColor: Colors.red[400],
        textColor: Colors.white,
      );
      return;
    }

    final api = Uri.parse('$url/UpdateProfile/');
    try {
      final request = http.MultipartRequest('POST', api);
      request.fields.addAll({
        'lid': lid ?? '',
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'place': placeController.text,
      });

      if (_photo != null) {
        request.files.add(await http.MultipartFile.fromPath('photo', _photo!.path));
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        final respData = jsonDecode(await response.stream.bytesToString());
        if (respData['status'] == 'ok') {
          Fluttertoast.showToast(
            msg: "Profile updated successfully",
            backgroundColor: Colors.green[400],
            textColor: Colors.white,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Profile()),
          );
        } else {
          Fluttertoast.showToast(
            msg: "Update failed",
            backgroundColor: Colors.red[400],
            textColor: Colors.white,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Server error",
          backgroundColor: Colors.red[400],
          textColor: Colors.white,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: $e",
        backgroundColor: Colors.red[400],
        textColor: Colors.white,
      );
    }
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Container(
  //       decoration: BoxDecoration(
  //         gradient: LinearGradient(
  //           begin: Alignment.topCenter,
  //           end: Alignment.bottomCenter,
  //           colors: [
  //             const Color(0xFF35577D),
  //             const Color(0xFF35577D).withOpacity(0.7),
  //             const Color(0xFF35577D),
  //           ],
  //           stops: const [0.0, 0.4, 0.8],
  //         ),
  //       ),
  //       child: SafeArea(
  //         child: SingleChildScrollView(
  //           padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               // Header
  //               Container(
  //                 padding: const EdgeInsets.all(24),
  //                 decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.circular(16),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: Colors.white.withOpacity(0.05),
  //                       blurRadius: 20,
  //                       offset: const Offset(0, 8),
  //                     ),
  //                   ],
  //                 ),
  //                 child: Column(
  //                   children: [
  //                     Row(
  //                       children: [
  //                         const Text(
  //                           "Update Profile",
  //                           style: TextStyle(
  //                             fontSize: 22,
  //                             fontWeight: FontWeight.bold,
  //                             color: Color(0xFF35577D),
  //                           ),
  //                         ),
  //                         const Spacer(),
  //                         Icon(
  //                           Icons.person,
  //                           color: const Color(0xFF35577D).withOpacity(0.8),
  //                           size: 24,
  //                         ),
  //                       ],
  //                     ),
  //                     const SizedBox(height: 8),
  //                     Text(
  //                       "Update your details to keep your profile current",
  //                       style: TextStyle(fontSize: 14, color: Colors.grey[600]),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               const SizedBox(height: 24),
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [deepTeal, tealAccent, tealLight],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Back Button
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: accentCyan.withOpacity(0.3)),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Update Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Info Banner
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: deepTeal.withOpacity(0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [tealLight, tealBright],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.edit_note_rounded, color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Edit Your Details",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: deepTeal,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Keep your profile information current",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Form
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: nameController,
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(color: Color(0xFF35577D)),
                          hintText: 'Enter your full name',
                          prefixIcon: Icon(Icons.person_rounded, color: Color(0xFF35577D)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: emailController,
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Color(0xFF35577D)),
                          hintText: 'Enter your email',
                          prefixIcon: Icon(Icons.email_rounded, color: Color(0xFF35577D)),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),

                      const SizedBox(height: 16),

                      TextFormField(
                        controller: phoneController,
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                        decoration: const InputDecoration(
                          labelText: 'Phone',
                          labelStyle: TextStyle(color: Color(0xFF35577D)),
                          hintText: 'Enter your phone number',
                          prefixIcon: Icon(Icons.phone_rounded, color: Color(0xFF35577D)),
                        ),
                        keyboardType: TextInputType.phone,
                      ),

                      const SizedBox(height: 16),
                      TextFormField(
                        controller: placeController,
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                        decoration: const InputDecoration(
                          labelText: 'Place',
                          labelStyle: TextStyle(color: Color(0xFF35577D)),
                          hintText: 'Enter your place',
                          prefixIcon: Icon(Icons.location_on_rounded, color: Color(0xFF35577D)),
                        ),
                      ),
                      const SizedBox(height: 16),

                      const Text(
                        "Upload Photo",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF35577D),
                        ),
                      ),
                      const SizedBox(height: 8),
                      _photo == null
                          ? (profileData != null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          profileData!['photo'],
                          height: 150,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text("No photo available", style: TextStyle(color: Colors.grey)),
                            ),
                          ),
                        ),
                      )
                          : Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text("No photo selected", style: TextStyle(color: Colors.grey)),
                        ),
                      ))
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(_photo!, height: 150, fit: BoxFit.cover),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _pickFile(ImageSource.gallery, true),
                              icon: const Icon(Icons.photo, size: 20),
                              label: const Text("Gallery"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF35577D).withOpacity(0.9),
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _pickFile(ImageSource.camera, true),
                              icon: const Icon(Icons.camera_alt, size: 20),
                              label: const Text("Camera"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF35577D).withOpacity(0.9),
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF35577D),
                            foregroundColor: Colors.white,),
                          onPressed: sendData,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Update Profile",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.check_circle_rounded, size: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFF35577D).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: const Color(0xFF35577D),
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Ensure all fields are filled and files are uploaded correctly",
                          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}