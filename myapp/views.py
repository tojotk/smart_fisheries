import datetime
import json
import random

from django.contrib import messages
from django.contrib.auth import authenticate, login,logout
from django.contrib.auth.hashers import make_password
from django.contrib.auth.models import Group
from django.core.files.storage import FileSystemStorage
from django.core.mail import send_mail
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render, redirect

from django.contrib.auth.models import User
# Create your views here.
from fisheries import settings
from .models import *


def loginn(request):
    return render(request,'index.html')

def adminlogout(request):
    logout(request)
    return redirect('/myapp/login/')


def login_post(request):
    uname=request.POST['USERNAME']
    passwd=request.POST['PASSWORD']
    user = authenticate(request, username=uname, password=passwd)
    if user is not None:
        print("hhh")
        if user.groups.filter(name="admin").exists():

            login(request, user)
            return redirect('/myapp/admin_home')

        elif user.groups.filter(name="BOAT OWNER").exists():
            if boat_owner.objects.filter(LOGIN_id=user.id,status="accept").exists():
                login(request, user)
                return redirect('/myapp/owner_home')
            elif boat_owner.objects.filter(LOGIN_id=user.id,status="reject").exists():
                messages.warning(request, "Rejected")
                return HttpResponse('<script>alert("Rejected");window.location="/myapp/login/";</script>')
            else:
                messages.warning(request, "Not verified")
                return HttpResponse('<script>alert("Not verified");window.location="/myapp/login/";</script>')
        elif user.groups.filter(name="OFFICER").exists():
                login(request, user)
                return redirect('/myapp/officer_home')
    else:
        messages.warning(request, "Invalid username or password")
    return render(request,'index.html')




def admin_home(request):
    return render(request,'admin/home.html')


def admin_view_user(request):
    users = user_table.objects.all()
    return render(request, 'admin/view user.html', {'user_list': users})

def admin_add_camera(request):
    if request.method == 'POST':
        cameraname = request.POST['name']

        cam = camera()
        cam.camera_name = cameraname

        cam.save()
        return redirect('/myapp/admin_view_cameras#a')
    return render(request,'ADMIN/ADD CAMERA.html')

def deletecamera(request,id):
    ob=camera.objects.get(id=id)
    ob.delete()
    return redirect('/myapp/admin_view_cameras#a')

def admin_add_officer(request):
    return render(request,'ADMIN/add officer.html')

def admin_add_officer_post(request):
    name=request.POST['name']
    department=request.POST['department']
    desgination=request.POST['designation']
    username=request.POST['username']
    email=request.POST['email']
    password=request.POST['password']
    phone=request.POST['phone']

    user = User.objects.create(username=username,password=make_password(password),first_name=name,email=email)
    user.save()
    user.groups.add(Group.objects.get(name="Officer"))

    var=officer_table()
    var.LOGIN=user
    var.name=name
    var.department=department
    var.phone=phone
    var.designation=desgination

    var.save()
    return redirect('/myapp/admin_viewofficer#a')

def deleteofficer(request,id):
    ob=officer_table.objects.get(LOGIN=id).delete()
    User.objects.get(id=id).delete()
    return redirect('/myapp/admin_viewofficer#a')


def admin_edit_officer(request,id):
    request.session['eid']=id
    ob=officer_table.objects.get(id=id)
    return render(request,'ADMIN/edit officer.html',{'data':ob})

def admin_edit_officer_post(request):
    name=request.POST['name']
    department=request.POST['department']
    desgination=request.POST['designation']
    phone=request.POST['contact']
    var=officer_table.objects.get(id=request.session['eid'])
    var.name=name
    var.department=department
    var.phone=phone
    var.designation=desgination
    var.save()
    return redirect('/myapp/admin_viewofficer#a')

def admin_sent_reply(request,id):
    request.session['complaintid']=id
    return render(request,'ADMIN/SENT REPLY.html')

def admin_sent_reply_post(request):
    reply=request.POST['name']
    complaint.objects.filter(id=request.session['complaintid']).update(reply=reply)
    return redirect('/myapp/admin_view_complaint#a')

def admin_verify_boat_owner_accept(request):
    ob=boat_owner.objects.all()
    return render(request,'ADMIN/VERIFY BOAT OWNER ACCEPT.html',{'data':ob})

def admin_view_boat_details(request):
    ob=boat.objects.all()
    return render(request,'ADMIN/VIEW BOAT DETAILS.html',{'data':ob})

def admin_view_cameras(request):
    ob=camera.objects.all()
    return render(request,'ADMIN/VIEW CAMERAS.html',{'data':ob})

def admin_view_complaint(request):
    data=complaint.objects.all()
    return render(request,'ADMIN/VIEW COMPLAINT.html',{"data":data})

def admin_view_droning_detection(request):
    ob=drowing_detection.objects.all()
    return render(request,'ADMIN/VIEW DRONING DETECTION.html',{'data':ob})

def  admin_view_suggestion(request):
    data=suggections.objects.all()
    return render(request,'ADMIN/VIEW SUGGESTION.html',{'suggestions':data})

def admin_view_trolling_details(request):
    data = trolling_details.objects.all()
    return render(request,'ADMIN/VIEW TROLLING DETAILS.html',{'data':data})

def admin_viewofficer(request):
    ob=officer_table.objects.all()
    return render(request,'ADMIN/viewofficer.html',{'data':ob})

def accept_boat_owner(request,id):
    boat_owner.objects.filter(LOGIN=id).update(status="accept")
    return redirect('/myapp/admin_verify_boat_owner_accept')

def reject_boat_owner(request,id):
    boat_owner.objects.filter(LOGIN=id).update(status="reject")
    return redirect('/myapp/admin_verify_boat_owner_accept')

def owner_home(request):
    return render(request,'BOAT OWNER/owner_home.html')

def boat_owner_add_boat(request):
    if request.method == 'POST':
        regno=request.POST['regno']
        capacity=request.POST['capacity']
        type=request.POST['type']
        # status=request.POST['status']
        var=boat()
        var.owner=boat_owner.objects.get(LOGIN_id=request.user.id)
        var.regno=regno
        var.capacity=capacity
        var.type=type
        var.status="pending"
        var.save()
        return redirect('/myapp/boat_owner_boat_own_view_boat_details')

    return render(request,'BOAT OWNER/ADD BOAT.html')


def delete_boat(request,id):
    boat.objects.get(id=id).delete()
    return redirect('/myapp/boat_owner_boat_own_view_boat_details')



def delete_suggestion(request,id):
    suggections.objects.get(id=id).delete()
    return redirect('/myapp/boat_owner_boat_own_view_suggestion')






def boat_owner_add_suggestion(request):
    return render(request,'BOAT OWNER/add suggestion.html')

def boat_owner_add_suggestion_post(request):
    suggect=request.POST['suggestion']
    v=suggections()
    v.owner=boat_owner.objects.get(LOGIN=request.user.id)
    v.suggection=suggect
    v.date=datetime.datetime.today()
    v.save()
    print('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb')
    return redirect('/myapp/boat_owner_boat_own_view_suggestion')


def boat_owner_add_trip_details(request):
    return render(request,'BOAT OWNER/add trip details.html')

def boat_owner_add_trip_details_post(request):
    sdate=request.POST['sdate']
    edate=request.POST['edate']
    frm=request.POST['from']
    to=request.POST['to']

    obj=trip()
    obj.start_date=sdate
    obj.end_date=edate
    obj.From=frm
    obj.To=to
    obj.status='not started'
    obj.boat=boat.objects.get(id=request.session['bid'])
    obj.save()
    k=request.session['bid']
    return redirect(f'/myapp/boat_owner_boat_own_view_trip_details/{k}#a')





def boat_owner_boat_own_view_boat_details(request):
    data=boat.objects.filter(owner__LOGIN_id=request.user.id)
    return render(request,'BOAT OWNER/BOAT OWN VIEW BOAT DETAILS.html',{"data":data})

def boat_owner_boat_own_view_reply(request):
    data = complaint.objects.filter(owner__LOGIN_id=request.user.id)
    return render(request,'BOAT OWNER/BOAT OWN VIEW REPLY.html',{"data":data})

def boat_owner_boat_own_view_suggestion(request):
    data=suggections.objects.all()
    return render(request,'BOAT OWNER/boat own view suggestion.html',{"data":data})

def boat_owner_boat_own_view_trip_details(request,id):
    request.session['bid']=id
    data=trip.objects.filter(boat_id=id)
    return render(request,'BOAT OWNER/BOAT OWN VIEW TRIP DETAILS.html',{"data":data})

def boat_owner_boat_own_view_trolling_details(request):
    data=trolling_details.objects.all()
    return render(request,'BOAT OWNER/BOAT OWN VIEW TROLLING DETAILS.html',{"data":data})

def boat_owner_drownig_detecetion(request):
    data=drowing_detection.objects.all()
    return render(request,'BOAT OWNER/DROWNIG DETECETION.html',{"data":data})

def boat_owner_edit_boat(request,id):

    request.session['bid'] = id
    ob = boat.objects.get(id=id)
    return render(request, 'BOAT OWNER/EDIT BOAT.html', {'data': ob})

def boat_owner_edit_boat_post(request):
    REG_NO = request.POST['reg_no']
    CAPACITY = request.POST['capacity']
    TYPE = request.POST['type']
    var = boat.objects.get(id=request.session['bid'])
    var.regno = REG_NO
    var.capacity = CAPACITY
    var.type = TYPE
    var.save()
    return redirect('/myapp/boat_owner_boat_own_view_boat_details#a')





def boat_owner_DELETE_trip_details(request,id):
    request.session['tid']=id
    data=trip.objects.get(id=id)
    data.delete()
    k = request.session['bid']
    return redirect(f'/myapp/boat_owner_boat_own_view_trip_details/{k}#a')


def boat_owner_edit_trip_details(request,id):
    request.session['tid']=id
    data=trip.objects.get(id=id)
    return render(request,'BOAT OWNER/EDIT TRIP DETAILS.html',{"data":data,"start_date":str(data.start_date),"end_date":str(data.end_date)})


def boat_owner_edit_trip_details_post(request):
    sdate=request.POST['sdate']
    edate=request.POST['edate']
    frm=request.POST['from']
    to=request.POST['to']

    obj=trip.objects.get(id=request.session['tid'])
    obj.start_date=sdate
    obj.end_date=edate
    obj.From=frm
    obj.To=to
    obj.status='pending'
    obj.boat=boat.objects.get(id=request.session['bid'])
    obj.save()
    k=request.session['bid']
    return redirect(f'/myapp/boat_owner_boat_own_view_trip_details/{k}#a')






def boat_owner_owner_registration(request):
    if request.method == 'POST':
        name = request.POST['name']
        phone = request.POST['phone']
        place = request.POST['place']
        post=request.POST['post']
        pin = request.POST['pin']
        email = request.POST['email']
        id_proof = request.FILES['id_proof']
        username = request.POST['username']
        password = request.POST['password']

        fs=FileSystemStorage()
        path=fs.save(id_proof.name,id_proof)

        user = User.objects.create(username=username,password=make_password(password),first_name=name,email=email)
        user.save()
        user.groups.add(Group.objects.get(name="BOAT OWNER"))
        var=boat_owner()
        var.LOGIN=user
        var.name=name
        var.phone=phone
        var.Post=post
        var.place=place
        var.pin=pin
        var.id_proof=path
        var.status='pending'
        var.save()
        return redirect('/myapp/login/')
    return render(request,'BOAT OWNER/OWNER REGISTRATION.html')






    # return render(request,'BOAT OWNER/OWNER REGISTRATION.html')

def boat_owner_owner_update_profile(request):
    data=boat_owner.objects.get(LOGIN_id=request.user.id)
    if request.method == 'POST':
        name = request.POST['name']
        phone = request.POST['phone']
        place = request.POST['place']
        post = request.POST['post']
        pin = request.POST['pin']



        var = boat_owner.objects.get(LOGIN_id=request.user.id)
        if 'id_proof' in request.FILES:
            id_proof = request.FILES['id_proof']

            fs = FileSystemStorage()
            path = fs.save(id_proof.name, id_proof)
            var.id_proof = path

        var.name = name
        var.phone = phone
        var.Post = post
        var.place = place
        var.pin = pin
        var.status = 'pending'
        var.save()
        return redirect('/myapp/boat_owner_owner_update_profile')


    return render(request,'BOAT OWNER/OWNER UPDATE PROFILE.html',{'data':data})

def boat_owner_send_complaint(request):
    data=illegal_activity.objects.all()
    return render(request,'BOAT OWNER/SEND COMPLAINT.html',{"data":data})

def boat_owner_send_complaint_post(request):
    complaints=request.POST['COMPLAINT']
    ob=complaint()
    ob.owner=boat_owner.objects.get(LOGIN_id=request.user.id)
    ob.complaint=complaints
    ob.date=datetime.datetime.today()
    ob.reply='pending'
    ob.save()


    return redirect('/myapp/boat_owner_boat_own_view_reply')



def boat_owner_update_trip_status(request,id):
    request.session['tid']=id
    return render(request,'BOAT OWNER/UPDATE TRIP STATUS.html')

def boat_owner_update_trip_status_post(request):
    status=request.POST['status']
    trip.objects.filter(id=request.session['tid']).update(status=status)
    id=request.session['tid']
    return redirect('/myapp/boat_owner_boat_own_view_boat_details')

def boat_owner_view_ban_notification(request):
    ob=drowing_detection.objects.filter(boat__owner__LOGIN__id=request.user.id)
    print(ob,"llllllllllllll")
    print(request.user.id)
    return render(request,'BOAT OWNER/VIEW BAN NOTIFICATION.html',{"val":ob})

def boat_owner_viewbandetails(request):
    ob=trolling_details.objects.all()
    return render(request,'BOAT OWNER/viewbandetails.html',{"val":ob})


def boat_owner_emergency_report(request):
    ob=emergency_report.objects.filter(boat__owner__LOGIN__id=request.user.id)
    return render(request,'BOAT OWNER/emergency report.html',{'data':ob})

def officer_home(request):
    # ob = officer_table.objects.get(LOGIN__id=request.user.id)
    return render(request,'OFFICER/officer_home.html')


def officer_view_profile(request):
    a=officer_table.objects.get(LOGIN=request.user.id)
    return render (request,'OFFICER/viewprofile.html',{'data':a})


def officer_add_trolling_details(request):
    return render(request,'OFFICER/ADD TROLLING DETAILS.html')


def add_trolling_post(request):
    f_area=request.POST['name']
    s_date=request.POST['sdate']
    e_date=request.POST['edate']
    remark=request.POST['remark']

    b=trolling_details()
    b.officer=officer_table.objects.get(LOGIN=request.user.id)
    b.fishind_area=f_area
    b.start_date=s_date
    b.end_date=e_date
    b.remarks=remark
    b.save()
    return redirect('/myapp/officer_view_trolling_details_officer')



def officer_ban_boat(request,id):
    request.session['bid']=id
    if request.method=="POST":
        regno=request.POST['name']
        ob=boat.objects.filter(regno=regno)
        if len(ob)>0:
            ob[0].status="BAN"
            ob[0].save()
            obb=ban()
            obb.monitor=illegal_activity.objects.get(id=id)
            obb.boat=ob[0]
            obb.status="ban"
            obb.save()
            return redirect("/myapp/officer_view_baned_boat#a")

    return render(request,'OFFICER/BAN BOAT.html')

def officer_edit_trolling_details(request,id):
    request.session['tid']=id
    data=trolling_details.objects.get(id=id)
    return render(request,'OFFICER/EDIT TROLLING DETAILS.html',{"val":data,"sdate":str(data.start_date),"edate":str(data.end_date)})


def edit_trolling_post(request):
    f_area=request.POST['name']
    s_date=request.POST['sdate']
    e_date=request.POST['edate']
    remark=request.POST['remark']
    b=trolling_details.objects.get(id=request.session['tid'])

    b.fishind_area=f_area
    b.start_date=s_date
    b.end_date=e_date
    b.remarks=remark
    b.save()
    return redirect('/myapp/officer_view_trolling_details_officer')



def delete_trolling_post(request,id):
    b=trolling_details.objects.get(id=id)
    b.delete()
    return redirect('/myapp/officer_view_trolling_details_officer')








def officer_register_officer(request):
    return render(request,'OFFICER/REGISTER OFFICER.html')

def officer_update_profile(request):
    return render(request,'OFFICER/UPDATE PROFILE.html')

def officer_view_baned_boat(request):
    # officer_ban_boat
    ob=ban.objects.all()
    ids=[]
    for i in ob:
        ids.append(i.monitor.id)

    data=illegal_activity.objects.all()
    for i in data:
        i.status="na"
        if i.id in ids:
            i.status="ban"

    return render(request,'OFFICER/VIEW BANED BOAT.html',{"data":data})

def officer_view_boat_verify(request):
    ob=boat.objects.filter(owner__status='accept')
    return render(request,'OFFICER/VIEW BOAT VERIFY.html',{'boats':ob})

def officer_verify_boat(request,id):
    ob=boat.objects.get(id=id)
    ob.status='Verified'
    ob.save()
    return redirect('/myapp/officer_view_boat_verify#a')

def officer_view_monitoring_details(request):
    data=report_illegal_activity.objects.all()
    return render(request,'OFFICER/VIEW MONITORING DETAILS.html',{"data":data})

def officer_view_trip_details(request,id):
    data=trip.objects.filter(boat__id=id)
    return render(request,'OFFICER/VIEW TRIP DETAILS.html',{"data":data})

def officer_manage_tips(request):
    ob=safety_tips.objects.all()
    return render(request,'OFFICER/manage tips.html',{"val":ob})

def officer_add_tip(request):

    return render(request,'OFFICER/add tip.html')

def officer_add_tip_post(request):
    if request.method == 'POST':
     date = datetime.datetime.today()
     title = request.POST['title']
     description = request.POST['desc']
     var=safety_tips()
     var.tittle=title
     var.date= date
     var.description=description
     var.officer=officer_table.objects.get(LOGIN__id=request.user.id)
     var.save()
     return redirect('/myapp/officer_manage_tips#a')




def officer_view_trolling_details_officer(request):
    c=trolling_details.objects.filter(officer__LOGIN_id=request.user.id)
    return render(request,'OFFICER/VIEW TROLLING DETAILS OFFICER.html',{'data':c})
# def DELETETIPS(request,id):
#     ob=safety_tips.objects.get(id=id).delete()
#     return redirect('/myapp/officer_manage_tips')


def delete_tips(request,id):
    safety_tips.objects.get(id=id).delete()
    return redirect('/myapp/officer_manage_tips')
#
# def notification(request):
#     lid=request.POST['lid']
#     date=request.POST['date']
#     location=request.POST['location']
#     ab=notification()
#     ab
#
#






#######################forgotpassword###########################
def ForgotPassword(request):
    return render(request,'forgot_password.html')

def forgotPassword_otp(request):
    if 'email' in request.POST:
        request.session['email'] = request.POST['email']
    email=request.session['email']
    try:
        user=User.objects.get(email=email)
    except User.DoesNotExist:
        messages.warning(request,'Email doesnt match')
        return redirect('/myapp/login/')
    otp=random.randint(100000,999999)
    request.session['otp']=str(otp)
    request.session['email'] = email

    send_mail('Your Verification Code',
    f'Your verification code is {otp}',
    settings.EMAIL_HOST_USER,
    [email],
    fail_silently=False)
    messages.success(request,'OTP sent To your Mail')
    return redirect('/myapp/verifyOtp/')

def verifyOtp(request):
    return render(request,'otpverification.html')

def verifyOtpPost(request):
    entered_otp=request.POST['entered_otp']
    if request.session.get('otp') == entered_otp:
        messages.success(request,'otp verified')
        return redirect('/myapp/new_password/')
    else:
        messages.warning(request,'Invalid OTP!!')
        return redirect('/myapp/login/')

def new_password(request):
    return render(request,'new_password.html')

def changePassword(request):
    newpassword=request.POST['newPassword']
    confirmPassword=request.POST['confirmPassword']
    if newpassword == confirmPassword:
        email=request.session.get('email')
        user = User.objects.get(email=email)
        user.set_password(confirmPassword)
        user.save()
        messages.success(request, 'Password Updated Successfully')
        return redirect('/myapp/login/')
    else:
        messages.warning(request, 'The password doesnt match!!')
        return redirect('/myapp/new_password/')





def forgotpasswordflutter(request):
    email = request.POST['email']
    try:
        user = User.objects.get(email=email)
    except User.DoesNotExist:
        return JsonResponse({'status': 'error', 'message': 'Email not found'})

    otp = random.randint(100000, 999999)
    PasswordResetOTP.objects.create(email=email, otp=otp)

    send_mail('Your Verification Code',
              f'Your verification code is {otp}',
              settings.EMAIL_HOST_USER,
              [email],
              fail_silently=False)
    return JsonResponse({'status': 'ok', 'message': 'OTP sent'})


def verifyOtpflutterPost(request):
    email = request.POST['email']
    entered_otp = request.POST['entered_otp']
    otp_obj = PasswordResetOTP.objects.filter(email=email).latest('created_at')
    if otp_obj.otp == entered_otp:
        return JsonResponse({'status': 'ok'})
    else:
        return JsonResponse({'status': 'error'})


def changePasswordflutter(request):
    email = request.POST['email']
    newpassword = request.POST['newPassword']
    confirmPassword = request.POST['confirmPassword']
    if newpassword == confirmPassword:
        try:
            user = User.objects.get(email=email)
            user.set_password(confirmPassword)
            user.save()
            return JsonResponse({'status': 'ok'})
        except User.DoesNotExist:
            return JsonResponse({'status': 'error', 'message': 'User not found'})
    else:
        return JsonResponse({'status': 'error', 'message': 'Passwords do not match'})




# ================================== user =============================

def FlutterLogin(request):
    username=request.POST['username']
    password=request.POST['password']
    user = authenticate(username=username,password=password)
    if user is not None:
        if user.groups.filter(name='USER').exists():
            login(request,user)
            return JsonResponse({'status':'ok','lid':user.id})
        else:
            return JsonResponse({'status':'fail'})
    else:
        return JsonResponse({'status': 'fail'})


def user_register(request):
    name=request.POST['name']
    email=request.POST['email']
    dob = request.POST['dob']
    phone = request.POST['phone']
    place = request.POST['place']
    photo = request.FILES['photo']
    username=request.POST['username']
    password = request.POST['password']
    user = User.objects.create(username=username, password=make_password(password))
    user.save()
    user.groups.add(Group.objects.get(name='USER'))
    ob=user_table()
    ob.name=name
    ob.email=email
    ob.dob=dob
    ob.phone=phone
    ob.place=place
    ob.photo=photo
    ob.LOGIN=user
    ob.save()

    return JsonResponse({"status":"ok"})




def view_profile(request):
    lid=request.POST['lid']
    i=user_table.objects.get(LOGIN=lid)
    data={
        'name': i.name,
        'email': i.email,
        'dob': str(i.dob),
        'phone': str(i.phone),
        'place': i.place,
        'photo': i.photo.url,
    }
    print(data)
    return JsonResponse({'status':'ok','data':data})


# def user_fishingrule(request):
#     data=rules.objects.all()
#     l=[]
#     for i in data :
#         l.append({
#             "id":i.id,
#         })
#
#     return JsonResponse({"status":"ok"})


def user_safetyguideline(request):
    data = safety_tips.objects.all()
    l = []
    for i in data:
        l.append({
            "id": i.id,
            "title": i.tittle,
            "date": i.date,
            "officer": i.officer.name,
            "description": i.description,
        })

    return JsonResponse({"status":"ok"})


def user_weatherprediction(request):
    return JsonResponse({"status":"ok"})

def user_addillegalfishing(request):
    image=request.FILES['image']
    description=request.POST['description']
    return JsonResponse({"status":"ok"})

def user_illegalfishing(request):
    data = illegal_activity.objects.all()
    l = []
    for i in data:
        l.append({
            "id": i.boat_id,
            "boat": i.boat,
            "date": i.date,
            "image": i.image,
            "description": i.description,
        })
    return JsonResponse({"status":"ok"})

def user_emergencyrequest(request):
    data = emergency_report.objects.all()
    l = []
    for i in data:
        l.append({
            "id": i.boat_id,
            "date": i.date,
            "boat": i.boat,
            "report": i.report,
            "type": i.type,
            "latitude": i.latitude,
            "longitude": i.longitude,
        })
    return JsonResponse({"status":"ok"})

def user_manageprofile(request):
    return JsonResponse({"status":"ok"})

def user_viewassignedboat(request):
    data = assignedboat.objects.all()
    l = []
    for i in data:
        l.append({
            "id": i.fisherman_id,
            "fisherman": i.fisherman,
            "boat": i.boat,
            "date": i.date,
            "status": i.status,
        })
    return JsonResponse({"status":"ok"})

def user_viewupdatelocation(request):
    return JsonResponse({"status":"ok"})

def user_viewtrip(request):
    lid=request.POST['lid']
    assign=assignedboat.objects.get(USER__LOGIN__id=lid)
    data = trip.objects.filter(boat__id=assign.boat.id)
    l = []
    for i in data:
        l.append({
            "id": i.id,
            "boat": i.boat.owner.name,
            "start_date": i.start_date,
            "end_date": i.end_date,
            "From": i.From,
            "To": i.To,
            "status": i.status,
        })

    return JsonResponse({"status":"ok",'data':l})

def user_viewupdatetripstatus(request):
    lid=request.POST['lid']
    data = trip.objects.all()
    l = []
    for i in data:
        l.append({
            "id": i.boat_id,
            "start_date": i.start_date,
            "end_date": i.end_date,
            "From": i.From,
            "To": i.To,
            "status": i.status,
        })
    return JsonResponse({"status":"ok","data":l})


def user_viewboat(request):
    lid = request.POST['lid']
    assign = assignedboat.objects.get(USER__LOGIN__id=lid)
    data = boat.objects.filter(id=assign.boat.id)
    print(data,"llllllllllllllll")
    l = []
    for i in data:
        l.append({
            "id": i.id,
            "owner": i.owner.name,
            "regno": i.regno,
            "capacity": i.capacity,
            "type": i.type,
            "status": i.status,
        })
    return JsonResponse({"status":"ok","data":l})



def user_viewsafetytips(request):
    data = safety_tips.objects.all()
    print(data,"llllllllllllllll")
    l = []
    for i in data:
        l.append({
            "id": i.id,
            "tittle": i.tittle,
            "date": str(i.date),
            "officer": i.officer.name,
            "description": i.description,

        })
    return JsonResponse({"status":"ok","data":l})


def UpdateProfile(request):
    lid=request.POST['lid']
    name=request.POST['name']
    email=request.POST['email']
    phone = request.POST['phone']
    place = request.POST['place']

    ob=user_table.objects.get(LOGIN__id=lid)
    ob.name=name
    ob.email=email
    ob.phone=phone
    ob.place=place
    if 'photo' in request.FILES:
        photo = request.FILES['photo']
        ob.photo = photo
        ob.save()

    ob.save()
    return JsonResponse({"status":"ok"})


def ViewMyReports(request):
    lid=request.POST['lid']
    mdata=[]
    ob=report_illegal_activity.objects.filter(USER__LOGIN__id=lid)
    for i in ob:
        data={
            'description':i.description,
            'image':i.image.url,
            'date':str(i.date),
        }
        mdata.append(data)
    return JsonResponse({'status':'ok','data':mdata})

def AddIllegalReport(request):
    lid=request.POST['lid']
    image=request.FILES['image']
    description=request.POST['description']
    ob=report_illegal_activity()
    ob.description=description
    ob.date=datetime.datetime.today()
    ob.image=image
    ob.USER=user_table.objects.get(LOGIN=lid)
    ob.save()
    return JsonResponse({'status':'ok'})
#
#
# def drowning_detction_fn(request):
#     boatt=request.POST['bid']
#     date=datetime.datetime.today()
#     time=datetime.datetime.now().time()
#     print(request.FILES)
#     image=request.FILES['image']
#
#     longitude=request.POST['longitude']
#     latitude=request.POST['latitude']
#
#     ob=drowing_detection()
#     ob.boat=boat.objects.get(id=boatt)
#     ob.date=date
#     ob.time=time
#     ob.image=image
#     ob.longitude=longitude
#     ob.latitude=latitude
#     ob.save()
#     return JsonResponse({'status':'ok'})

def drowning_notification(request):
    ob=drowing_detection.objects.all()

    return render(request,"BOAT OWNER/drowning notification.html",{"data":ob})




def EmergencySos(request):
    data = json.loads(request.body)
    lid=data.get('lid')
    latitude=data.get('latitude')
    longitude = data.get('longitude')
    k=assignedboat.objects.get(USER__LOGIN__id=lid)
    ob=emergency_report()
    ob.date=datetime.datetime.today()
    ob.latitude=latitude
    ob.user=user_table.objects.get(LOGIN__id=lid)
    ob.boat=boat.objects.get(id=k.boat.id)
    ob.report="Emergency Action Needed"
    ob.type='emergency'
    ob.longitude=longitude
    ob.save()
    return JsonResponse({"status":"ok"})


from django.contrib import messages


def AssignBoat(request, id):
    request.session['aid'] = id
    if request.method == 'POST':
        user_id = request.POST['user']
        boat_id = request.POST['boat']

        # Check if user already has an assigned boat
        if assignedboat.objects.filter(USER_id=user_id).exists():
            messages.error(request, "This user is already assigned to a boat.")
        else:
            assignedboat.objects.create(
                boat_id=boat_id,
                USER_id=user_id,
                date=datetime.datetime.today(),
                status='Assigned'
            )
            messages.success(request, "Boat assigned successfully!")

    ob = assignedboat.objects.filter(boat__id=id)
    boats = boat.objects.filter(owner__LOGIN__id=request.user.id)
    users = user_table.objects.all()
    return render(request, 'BOAT OWNER/manage_assign.html', {'data': ob, 'boats': boats, 'users': users})

def DeleteAssign(request,id):
    assignedboat.objects.get(id=id).delete()
    a=request.session['aid']
    return redirect(f'/myapp/AssignBoat/{a}/#a')


import datetime
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from .models import (
    drowing_detection, boat, trolling_details,
    illegal_activity, monitoring, officer_table
)


@csrf_exempt
def drowning_detction_fn(request):
    """Handle drowning detection alerts with GPS location"""
    try:
        boatt = request.POST['bid']
        date = datetime.datetime.today().date()
        time = datetime.datetime.now().time()
        image = request.FILES['image']

        # Get GPS coordinates from request
        longitude = request.POST.get('longitude', '0.0')
        latitude = request.POST.get('latitude', '0.0')

        # Save drowning detection record
        ob = drowing_detection()
        ob.boat = boat.objects.get(id=boatt)
        ob.date = date
        ob.time = time
        ob.image = image
        ob.longitude = longitude
        ob.latitude = latitude
        ob.save()

        return JsonResponse({
            'status': 'ok',
            'message': 'Drowning alert saved successfully',
            'id': ob.id
        })
    except Exception as e:
        return JsonResponse({
            'status': 'error',
            'message': str(e)
        }, status=400)


@csrf_exempt
def TrollingDetection(request):
    """Handle boat detection during trolling periods"""
    try:
        date = datetime.datetime.today().date()
        image = request.FILES['image']
        detection_type = request.POST.get('detection_type', 'boat_detected')

        # Get GPS coordinates
        longitude = request.POST.get('longitude', '0.0')
        latitude = request.POST.get('latitude', '0.0')

        # Check if any trolling is active for this location/date
        active_trollings = trolling_details.objects.filter(
            start_date__lte=date,
            end_date__gte=date
        )

        if active_trollings.exists():
            # This is during a trolling period - save as illegal activity
            # Try to identify the boat (you might need additional logic here)
            # For now, we'll get the first boat or create a generic entry

            try:
                # You might want to add boat identification logic here
                detected_boat = boat.objects.first()  # Placeholder

                ob = illegal_activity()
                ob.boat = detected_boat
                ob.date = date
                ob.image = image
                ob.description = f"Boat detected during trolling period at ({latitude}, {longitude})"
                ob.save()

                return JsonResponse({
                    'status': 'illegal_activity',
                    'message': 'Boat detected during trolling period - saved as illegal activity',
                    'trolling_areas': list(active_trollings.values_list('fishind_area', flat=True)),
                    'id': ob.id
                })
            except Exception as e:
                return JsonResponse({
                    'status': 'error',
                    'message': f'Error saving illegal activity: {str(e)}'
                }, status=400)
        else:
            # No active trolling - save as normal monitoring
            ob = monitoring()
            ob.violation = 'Boat detected - No trolling period'
            ob.date = date
            ob.time = datetime.datetime.now().time()
            ob.image = image
            ob.save()

            return JsonResponse({
                'status': 'monitoring',
                'message': 'Boat detected - saved as normal monitoring',
                'id': ob.id
            })

    except Exception as e:
        return JsonResponse({
            'status': 'error',
            'message': str(e)
        }, status=400)


@csrf_exempt
def MonitoringDetection(request):
    """Handle general monitoring data (non-violation detections)"""
    try:
        date = datetime.datetime.today().date()
        time = datetime.datetime.now().time()
        image = request.FILES.get('image')

        violation = request.POST.get('violation', 'General monitoring')
        description = request.POST.get('description', '')

        ob = monitoring()
        ob.violation = violation
        ob.date = date
        ob.time = time
        if image:
            ob.image = image
        ob.save()

        return JsonResponse({
            'status': 'ok',
            'message': 'Monitoring data saved successfully',
            'id': ob.id
        })
    except Exception as e:
        return JsonResponse({
            'status': 'error',
            'message': str(e)
        }, status=400)


@csrf_exempt
def CheckTrollingStatus(request):
    """Check if current date/location is within any trolling period"""
    try:
        date_str = request.POST.get('date', str(datetime.datetime.today().date()))
        check_date = datetime.datetime.strptime(date_str, '%Y-%m-%d').date()

        active_trollings = trolling_details.objects.filter(
            start_date__lte=check_date,
            end_date__gte=check_date
        )

        if active_trollings.exists():
            trolling_list = []
            for trolling in active_trollings:
                trolling_list.append({
                    'id': trolling.id,
                    'officer': trolling.officer.id if trolling.officer else None,
                    'fishing_area': trolling.fishind_area,
                    'start_date': str(trolling.start_date),
                    'end_date': str(trolling.end_date),
                    'remarks': trolling.remarks
                })

            return JsonResponse({
                'status': 'active_trolling',
                'trolling_periods': trolling_list
            })
        else:
            return JsonResponse({
                'status': 'no_trolling',
                'message': 'No active trolling periods'
            })

    except Exception as e:
        return JsonResponse({
            'status': 'error',
            'message': str(e)
        }, status=400)


