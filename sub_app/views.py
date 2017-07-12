import boto3

from django.http import JsonResponse
from django.utils import timezone
from django.views.decorators.csrf import csrf_exempt

from urllib.parse import urlencode


@csrf_exempt
def post_media(request, **kwargs):
    pass
