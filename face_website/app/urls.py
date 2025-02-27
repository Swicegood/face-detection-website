from django.urls import path
from django.contrib.staticfiles.storage import staticfiles_storage
from django.views.generic.base import RedirectView
from app.views import (home_redirect_view, overview_view, success_view, failure_view, table_view)
from django.conf import settings
from django.conf.urls.static import static


urlpatterns = [
    path('', home_redirect_view, name='home_redirect'),
    path('overview/', overview_view, name='overview'),    
    path('favicon.ico', RedirectView.as_view(url=staticfiles_storage.url('img/favicon.ico'))),
    path('success/', success_view, name="success"),
    path('failure/', failure_view, name="failure"),
    path('data-json/<int:num_events>', table_view.as_view(), name='data-json')
]
if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL,document_root=settings.STATIC_ROOT) 
    urlpatterns += static(settings.MEDIA_URL,document_root=settings.MEDIA_ROOT)