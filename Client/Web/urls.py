from django.conf.urls import url
from django.views.generic.base import RedirectView
#from django.contrib.staticfiles.urls import staticfiles_urlpattern
from . import views

urlpatterns = [
	url(r'^$', views.index, name='index'),
	url(r'^validateLogin', views.validateLogin, name='validateLogin'),
	url(r'^expert_list',views.expertList, name='expertList'),
	#url(r'^patientTest/(?P<pat_recent>[0-9]+)$', views.test_result, name='test_result'),
	url(r'^patientTest', views.check_page, name='check_page'),
	#url(r'^patientTest?test_id=(?P<pat_recent>[0-9]+)$', views.test_result, name='test_result'),
	#url(r'^playFile/(?<pat_recent>[0-9]+)/1$', views.get_recordedfile, name='get_recordedfile'),
	url(r'^patientResult', views.result_page, name='result_page'),
]

#urlpatterns += staticfiles_urlpatterns()
