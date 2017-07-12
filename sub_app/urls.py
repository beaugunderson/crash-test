from django.conf.urls import url
from .views import post_media

urlpatterns = [
    url(r'media/(?P<token>(.+))/?', post_media),
]
