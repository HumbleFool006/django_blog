from django.shortcuts import render
from django.http import HttpResponse
from .models import Review
import json
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

