from demrobo.models import Patients
from demrobo.models import Expert
from demrobo.models import CareGiver
from demrobo.models import TestResults
from django.shortcuts import get_object_or_404, redirect, render
from django.http import HttpResponse, HttpResponseRedirect
from django.core.urlresolvers import reverse
from django.contrib.sessions.models import Session
from django.contrib import messages

from .forms import ExpertForm

from boto.s3.connection import S3Connection

def index(request):
	return render(request, 'demrobo/index.html')

def validateLogin(request):
	success = -1

	if(request.method == "POST"):
		inputExpert = request.POST.get("checkExpert", "")
		inputCaregiver = request.POST.get("checkCaregiver", "")
		inputID = request.POST.get("EXPERT_ID", "")
		inputPW = request.POST.get("EXPERT_PW", "")
		
		userID = ""
		userPW = ""
		inputOrigin = ""
		
		if(inputExpert == "on" and inputCaregiver == "on"):
			return redirect('/')

		form = ExpertForm(request.POST or None)

		if (form.is_valid()):
			print "form is valid!!"

		if(inputExpert == "on"):
			userID = Expert.objects.get(EXPERT_ID=inputID)
			userPW = Expert.objects.get(EXPERT_PW=inputPW)

		elif(inputCaregiver == "on"):
			userID = CareGiver.objects.get(CARE_ID=inputID)
			userPW = CareGiver.objects.get(CARE_PW=inputPW)

		else:
			return redirect('/')

		if(userID.EXPERT_IDX and userPW.EXPERT_IDX):
			success = 1

		if(success == 1):
			target = userID.EXPERT_IDX
			request.session['session_login'] = target
			request.session.modified = True

			#return HttpResponseRedirect('/expert_list/')
			#return redirect('/expert_list/', context)
			return HttpResponseRedirect('/expert_list/')

		else:
			print "failure"
			return redirect('/')

		return redirect('/')

def expertList(request):
	ex_idx = request.session.get('session_login')
	print ex_idx	
	
	patientList = Patients.objects.filter(PAT_CHARGE=ex_idx)
	print patientList
	
	return render(request, 'demrobo/expert_list.html', {'patientList' : patientList} )

def test_mark(request, pat_recent):
	print "HERE IS FOR TEST MARKING"
	
	return render(request, 'demrobo/expert_marking.html')

#def test_result(request, pat_recent):
#	print "test result should be here"
#	testResult = TestResults.objects.filter(TEST_IDX=pat_recent)
#
#	print testResult
#	if (testResult.count() == 0):
#		print "TEST WITH NOT SUCCEED RESULT"
	#conn = boto.connect_s3('aws access key', 'aws secret key')
	#bucket = conn.get_bucket('//bucketName')
	#s3_file_path = bucket.get_key('path/to/file/')
	#url = s3_file_path.generate_url(expries_in=600)
#
#
#	return render(request, 'demrobo/checking_page.html')

def check_page(request):

	test_idx = request.GET.get('test_id')
	testResult = TestResults.objects.filter(TEST_IDX=test_idx)

	print testResult

	if(testResult.count() == 0):
		print "TEST WITH NOT SUCCEED RESULT"
	
	LOCAL_PATH = 'tmp/'

	AWS_ACCESS_KEY_ID = ''
	AWS_SECRET_ACCESS_KEY = ''
	BUCKET_NAME = ''

	connection = S3Connection('AKIAJAH3YVUX2JAOSB7Q', 'ckck1234')
	bucket = connection.get_bucket('robodem')
	key = bucket.get_key('/PAT_17/20180704142809/20180704142751_3.m4a', validate=False)
	url = key.generate_url(86400)
	
	return render(request, 'demrobo/checking_page.html')

def get_recordedfile(request, pat_recent):

	return render(request)


def result_page(request):

	return render(request, 'demrobo/test_result.html')
