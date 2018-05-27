from django.utils.deprecation import MiddlewareMixin
from django.http import HttpResponse

class Test(MiddlewareMixin):
	def __init__(self, get_response):
		self.get_response = get_response

	def process_request(self, request):
		print("arin")

	def process_view(self, request, callback, callback_args, callback_kwargs):
		print("ask")
		print(callback)

	def process_response(self, request, response):
		print("assakk")
		print(response)
		return response

class Test1(MiddlewareMixin):
	def __init__(self, get_response):
		self.get_response = get_response

	def process_request(self, request):
		print("arin1")

	def process_view(self, request, callback, callback_args, callback_kwargs):
		print("ask1")
		print(callback)

	def process_response(self, request, response):
		print("assakk1")
		print(response)
		return response
