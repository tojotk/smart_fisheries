
from django.contrib import admin
from django.urls import path, include

from . import views

urlpatterns = [
    path('login/',views.loginn),
    path('adminlogout/',views.adminlogout),
    path('login_post',views.login_post),
    path('admin_home',views.admin_home),
    path('admin_view_user',views.admin_view_user),

    path('admin_add_camera',views.admin_add_camera),
    path('deletecamera/<id>',views.deletecamera),
    # path('admin_add_camera_post/',views.admin_add_camera_post),

    path('admin_add_officer',views.admin_add_officer),
    path('deleteofficer/<id>',views.deleteofficer),
    path('admin_add_officer_post/',views.admin_add_officer_post),

    path('admin_edit_officer/<id>',views.admin_edit_officer),
    path('admin_edit_officer_post',views.admin_edit_officer_post),
    path('admin_sent_reply/<id>',views.admin_sent_reply),
    path('admin_sent_reply_post',views.admin_sent_reply_post),
    path('admin_verify_boat_owner_accept',views.admin_verify_boat_owner_accept),
    path('admin_view_boat_details',views.admin_view_boat_details),
    path('admin_view_cameras',views.admin_view_cameras),
    path('admin_view_complaint',views.admin_view_complaint),
    path('admin_view_droning_detection',views.admin_view_droning_detection),
    path('admin_view_suggestion',views.admin_view_suggestion),
    path('admin_view_trolling_details',views.admin_view_trolling_details),
    path('admin_viewofficer',views.admin_viewofficer),
    path('reject_boat_owner/<id>', views.reject_boat_owner),
    path('accept_boat_owner/<id>', views.accept_boat_owner),

    path('owner_home',views.owner_home),
    path('boat_owner_add_boat',views.boat_owner_add_boat),
    # path('boat_owner_add_boat_post/',views.boat_owner_add_boat_post),
    path('boat_owner_add_suggestion',views.boat_owner_add_suggestion),
    path('boat_owner_add_suggestion_post/',views.boat_owner_add_suggestion_post),
    path('boat_owner_add_trip_details/',views.boat_owner_add_trip_details),
    path('boat_owner_add_trip_details_post',views.boat_owner_add_trip_details_post),
    path('boat_owner_boat_own_view_boat_details',views.boat_owner_boat_own_view_boat_details),
    path('boat_owner_boat_own_view_reply',views.boat_owner_boat_own_view_reply),
    path('boat_owner_boat_own_view_reply',views.boat_owner_boat_own_view_reply),
    path('boat_owner_boat_own_view_suggestion',views.boat_owner_boat_own_view_suggestion),
    path('boat_owner_boat_own_view_trip_details/<id>',views.boat_owner_boat_own_view_trip_details),
    path('delete_suggestion/<id>',views.delete_suggestion),
    path('boat_owner_boat_own_view_trolling_details',views.boat_owner_boat_own_view_trolling_details),
    path('boat_owner_drownig_detecetion',views.boat_owner_drownig_detecetion),
    path('boat_owner_emergency_report',views.boat_owner_emergency_report),
    path('boat_owner_viewbandetails',views.boat_owner_viewbandetails),

    path('boat_owner_DELETE_trip_details/<id>', views.boat_owner_DELETE_trip_details),
    path('boat_owner_edit_boat/<id>', views.boat_owner_edit_boat),
    path('boat_owner_edit_boat_post', views.boat_owner_edit_boat_post),
    path('boat_owner_edit_trip_details_post', views.boat_owner_edit_trip_details_post),

    path('boat_owner_edit_trip_details/<id>',views.boat_owner_edit_trip_details),
    path('boat_owner_owner_registration',views.boat_owner_owner_registration),
    path('boat_owner_owner_update_profile',views.boat_owner_owner_update_profile),
    path('boat_owner_send_complaint',views.boat_owner_send_complaint),
    path('boat_owner_update_trip_status/<id>',views.boat_owner_update_trip_status),
    path('boat_owner_update_trip_status_post',views.boat_owner_update_trip_status_post),
    path('boat_owner_view_ban_notification',views.boat_owner_view_ban_notification),
    path('officer_add_trolling_details',views.officer_add_trolling_details),
    path('officer_ban_boat/<id>',views.officer_ban_boat),
    path('officer_edit_trolling_details/<id>',views.officer_edit_trolling_details),
    path('officer_register_officer',views.officer_register_officer),
    path('officer_update_profile',views.officer_update_profile),
    path('officer_view_baned_boat',views.officer_view_baned_boat),
    path('officer_view_boat_verify',views.officer_view_boat_verify),
    path('officer_view_monitoring_details',views.officer_view_monitoring_details),
    path('officer_verify_boat/<id>',views.officer_verify_boat),
    path('officer_view_trip_details/<id>',views.officer_view_trip_details),
    path('officer_view_trolling_details_officer',views.officer_view_trolling_details_officer),
    path('officer_add_tip',views.officer_add_tip),
    path('officer_add_tip_post',views.officer_add_tip_post),
    path('officer_view_profile',views.officer_view_profile),
    path('add_trolling_post',views.add_trolling_post),

    path('officer_manage_tips',views.officer_manage_tips),
    path('officer_home',views.officer_home),
    # path('DELETETIPS/<id>',views.DELETETIPS),
    path('delete_tips/<id>',views.delete_tips),
    path('delete_boat/<id>',views.delete_boat),
    path('boat_owner_send_complaint_post',views.boat_owner_send_complaint_post),
    path('edit_trolling_post',views.edit_trolling_post),
    path('delete_trolling_post/<id>',views.delete_trolling_post),
    path('boat_owner_boat_own_view_trip_details/<id>',views.boat_owner_boat_own_view_trip_details),

    path('ForgotPassword/', views.ForgotPassword),
    path('forgotpasswordflutter/', views.forgotpasswordflutter),
    path('verifyOtpflutterPost/', views.verifyOtpflutterPost),
    path('changePasswordflutter/', views.changePasswordflutter),
    path('forgotPassword_otp/', views.forgotPassword_otp),
    path('verifyOtp/', views.verifyOtp),
    path('verifyOtpPost/', views.verifyOtpPost),
    path('new_password/', views.new_password),
    path('changePassword/', views.changePassword),


    path('FlutterLogin/', views.FlutterLogin),
    path('user_viewtrip/', views.user_viewtrip),
    path('user_viewboat/', views.user_viewboat),
    path('user_viewsafetytips/', views.user_viewsafetytips),
    path('user_register/', views.user_register),
    path('view_profile/', views.view_profile),
    path('UpdateProfile/', views.UpdateProfile),
    path('ViewMyReports/', views.ViewMyReports),
    path('AddIllegalReport/', views.AddIllegalReport),
    # path('drowning_detction_fn/', views.drowning_detction_fn),
    path('EmergencySos/', views.EmergencySos),
    path('AssignBoat/<id>/', views.AssignBoat),
    path('DeleteAssign/<id>/', views.DeleteAssign),
    path('drowning_detction_fn/', views.drowning_detction_fn, name='drowning_detection'),

    # New boat/trolling detection endpoint
    path('TrollingDetection/', views.TrollingDetection, name='trolling_detection'),

    # General monitoring endpoint
    path('MonitoringDetection/', views.MonitoringDetection, name='monitoring_detection'),

    # Check trolling status
    path('CheckTrollingStatus/', views.CheckTrollingStatus, name='check_trolling_status'),




]
