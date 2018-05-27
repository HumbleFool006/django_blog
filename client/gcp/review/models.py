from django.db import models
from django.contrib.auth.models import AbstractUser, AbstractBaseUser
# Create your models here.
class Review(models.Model):
	title = models.CharField(max_length=30)
	content = models.CharField(max_length=100)
	name = models.CharField(max_length=100)
	summa = models.CharField(max_length=100)


class UserManager(models.Manager):
	def get_queryset(self):
		return super(UserManager, self).get_queryset().filter()

class User(AbstractBaseUser):
	username = models.CharField(max_length=200, unique=True)
	USERNAME_FIELD = "username"
	objects = UserManager()

class Profile(models.Model):
	user = models.OneToOneField(User, on_delete=models.CASCADE)
	bio = models.TextField(max_length=500, blank=True, default="developer")
	location = models.CharField(max_length=30, blank=True, default="Tuticorin")
	birth_date = models.DateField(null=True, blank=True)

