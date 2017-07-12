from django.conf.urls import include, url
from django.contrib import admin

import sub_app.urls

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^sub-app/', include(sub_app.urls)),
]
