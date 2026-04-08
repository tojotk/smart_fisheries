from django.contrib.auth.models import User
from django.db import models

# Create your models here.
class officer_table(models.Model):
    LOGIN=models.ForeignKey(User,on_delete=models.CASCADE)
    name=models.CharField(max_length=100)
    department=models.CharField(max_length=100)
    phone=models.BigIntegerField()
    designation=models.CharField(max_length=100)




class boat_owner(models.Model):
    LOGIN=models.ForeignKey(User, on_delete=models.CASCADE)
    name=models.CharField(max_length=100)
    phone=models.BigIntegerField()
    place=models.CharField(max_length=100)
    Post=models.CharField(max_length=100)
    pin=models.BigIntegerField()
    id_proof=models.FileField()
    status=models.CharField(max_length=500)



class boat(models.Model):
    owner=models.ForeignKey(boat_owner,on_delete=models.CASCADE)
    regno=models.IntegerField()
    capacity=models.BigIntegerField()
    type=models.CharField(max_length=100)
    status=models.CharField(max_length=500)


class trolling_details(models.Model):
    officer=models.ForeignKey(officer_table,on_delete=models.CASCADE)
    fishind_area=models.CharField(max_length=500)
    start_date=models.DateField()
    end_date=models.DateField()
    remarks=models.CharField(max_length=500)

class suggections(models.Model):
    owner=models.ForeignKey(boat_owner,on_delete=models.CASCADE)
    suggection=models.CharField(max_length=100)
    date=models.DateField()


class complaint(models.Model):
    owner=models.ForeignKey(boat_owner,on_delete=models.CASCADE)
    complaint=models.CharField(max_length=100)
    date=models.DateField()
    reply=models.CharField(max_length=50)




class drowing_detection(models.Model):
    boat=models.ForeignKey(boat,on_delete=models.CASCADE)
    date=models.DateField()
    time=models.TimeField()
    image=models.FileField()
    latitude=models.FloatField()
    longitude=models.FloatField()


class trip(models.Model):
    boat=models.ForeignKey(boat,on_delete=models.CASCADE)
    start_date=models.DateField()
    end_date=models.DateField()
    From=models.CharField(max_length=20)
    To=models.CharField(max_length=20)
    status=models.CharField(max_length=20)

class camera(models.Model):
    camera_name=models.CharField(max_length=25)
#
# class rules(models.Model):
#     officer=models.ForeignKey(officer_table,on_delete=models.CASCADE)
#     rules=models.CharField(max_length=100)
#     Date=models.DateField()
#     description=models.CharField(max_length=200)
#

class notification(models.Model):
    date=models.DateField()
    location=models.CharField(max_length=100)
    notification=models.CharField(max_length=24)


class safety_tips(models.Model):
    tittle=models.CharField(max_length=25)
    date=models.DateField()
    officer=models.ForeignKey(officer_table,on_delete=models.CASCADE)
    description=models.CharField(max_length=100)








class officer_add_tip(models.Model):
      date=models.DateField()
      title=models.CharField(max_length=50)
      description=models.FloatField()

class PasswordResetOTP(models.Model):
      email = models.EmailField()
      otp = models.CharField(max_length=6)
      created_at = models.DateTimeField(auto_now_add=True)


class user_table(models.Model):
    LOGIN=models.ForeignKey(User,on_delete=models.CASCADE)
    name = models.CharField(max_length=50)
    email = models.EmailField()
    dob = models.DateField()
    phone = models.BigIntegerField()
    place = models.CharField(max_length=100)
    photo = models.FileField()

class assignedboat(models.Model):
    USER = models.ForeignKey(user_table,on_delete=models.CASCADE)
    boat = models.ForeignKey(boat,on_delete=models.CASCADE)
    date = models.DateField()
    status = models.CharField(max_length=50)

class report_illegal_activity(models.Model):
    USER = models.ForeignKey(user_table,on_delete=models.CASCADE)
    date = models.DateField()
    image = models.FileField()
    description = models.CharField(max_length=100)




class emergency_report(models.Model):
      date=models.DateField()
      boat=models.ForeignKey(boat,on_delete=models.CASCADE)
      user=models.ForeignKey(user_table,on_delete=models.CASCADE)
      report=models.CharField(max_length=100)
      type=models.CharField(max_length=100)
      latitude=models.FloatField()
      longitude=models.FloatField()


class monitoring(models.Model):
    violation=models.CharField(max_length=50)
    date=models.DateField()
    time=models.TimeField()
    image=models.FileField()


class illegal_activity(models.Model):
     boat=models.ForeignKey(boat,on_delete=models.CASCADE)
     date=models.DateField()
     image=models.FileField()
     description=models.CharField(max_length=100)

class ban (models.Model):
    monitor=models.ForeignKey(illegal_activity,on_delete=models.CASCADE)
    boat=models.ForeignKey(boat,on_delete=models.CASCADE)
    status=models.CharField(max_length=20)
