from django.db import models
# Create your models here.
class Review(models.Model):
	title = models.CharField(max_length=30)
	content = models.CharField(max_length=100)
	name = models.CharField(max_length=100)
