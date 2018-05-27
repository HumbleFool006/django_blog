from django.shortcuts import render
from django.http import HttpResponse
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login
from .models import Review
from django.conf import settings
import json
from review.models import User, Profile
# Create your views here.
def post_review(request):
	data = Review(title=request.POST['title'], name=request.POST['username'], content=request.POST['contents'])
	data.save()
	return HttpResponse(data.id)

def get_reviews(request):
	output = []
	data = Review.objects.all()
	for i in data:
		result = {}
		result['title'] = i.title;
		result['username'] = i.name;
		result['contents'] = i.content;
		output.append(result)
	final_dict = {}
	final_dict['output'] = output
	print(final_dict)
	return HttpResponse(json.dumps(final_dict))

def login_view(request):
	try:
		user = User.objects.get(username=request.POST["username"], password=request.POST["password"])
	except Exception as e:
		return HttpResponse("user not found", status=403)
	login(request, user)
	return HttpResponse("logged in", status=200)

def signup_view(request):
	try:
		user = User.objects.get(username=request.POST["username"])
		return HttpResponse("UserAlready Present",  status=401)
	except Exception as e:
		pass
	user = User(username=request.POST["username"], password=request.POST["password"])
	user.save()
	Profile(user=user).save()
	login(request, user)
	return HttpResponse("done", status=200)
