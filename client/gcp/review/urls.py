from django.urls import include, path, re_path
from .views import post_review, get_reviews
urlpatterns = [
re_path('^post/', post_review),
re_path('^list/', get_reviews)
]