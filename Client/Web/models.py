from __future__ import unicode_literals
from django.utils import timezone
from django.db import models
from django.conf import settings

import hashlib

class Expert(models.Model):
	EXPERT_IDX = models.IntegerField(primary_key = True)
	EXPERT_ID = models.TextField(max_length = 15, null = False)
	EXPERT_PW = models.TextField(max_length = 20, null = False)

	#PAT_IDX = models.ForeignKey(Patients, on_delete = models.CASCADE)

class Patients(models.Model):
	PAT_IDX = models.IntegerField(primary_key = True)
	PAT_NAME = models.TextField(max_length = 50)
	PAT_BIRTH = models.TextField(max_length = 8)
	PAT_PHONE = models.TextField(max_length = 10)
	#PAT_EDUCATION = models.TextField(max_length = 20)   ## SHOULD BE INTEGER
	PAT_EDUCATION = models.IntegerField()
	PAT_HOSPITAL = models.TextField(max_length = 100)
	PAT_RECENT = models.TextField(max_length = 14)
	PAT_ID = models.TextField(max_length = 15, null = False)
	PAT_PW = models.TextField(max_length = 100, null = False, default='0000')
	
	#CARE_IDX = models.ForeignKey(CareGiver, on_delete = models.CASCADE)
	#EXPERT_IDX = models.ForeignKey(Expert, on_delete = models.CASCADE)
	PAT_CHARGE = models.IntegerField(default = 1)

	NORMAL = 'NOR'
	MCI = 'MCI'
	SUSPICIOUS = 'SUS'
	PAT_GRADE_CHOICES = (
		(NORMAL, 'Normal State'),
		(MCI, 'Mild Cognitive Disorder'),
		(SUSPICIOUS, 'Suspicious State')
	)
	PAT_STATE = models.CharField(max_length = 3, choices = PAT_GRADE_CHOICES, default=NORMAL)

	#def __init__(self, PAT_PW):
	#	self.PAT_PW = PAT_PW;

	#def __setattr__(self, PAT_PW, val):
	#	val = hashlib.md5(val.encode('utf-8')).hexdigest()
	#	super(Patients, self).__setattr__(PAT_PW, val)

	#def __getattr__(self, PAT_PW):
	#	return super(Patients, self).__getattr__(PAT_PW)

class CareGiver(models.Model):
	CARE_IDX = models.IntegerField(primary_key = True)
	CARE_ID = models.TextField(max_length = 15, null = False)
	CARE_PW = models.TextField(max_length = 15, null = False)

	#PAT_IDX = models.ForeignKey(Patients, on_delete = models.CASCADE)

#class Expert(models.Model):
	#EXPERT_IDX = models.IntegerField(primary_key = True)
	#EXPERT_ID = models.CharField(null = False, max_length = 15)
	#EXPERT_PW = models.CharField(null = False, max_length = 20)

	#PAT_IDX = models.ForeignKey(Patients, on_delete = models.CASCADE)

class TestResults(models.Model):
	#TEST_IDX = models.IntegerField(primary_key = True, validators[MaxValueValidator(999999999999)])
	TEST_IDX = models.IntegerField(primary_key = True)
	PAT_IDX = models.ForeignKey(Patients)

	## RANDOMIZED TEST SET
	TEST_SET = models.SmallIntegerField()
	## CREATED TEST SET BY CLIENT
	TEST_FOURTH_SET = models.TextField()

	## SCORES
	TEST_WORDCNT_ONE = models.SmallIntegerField(default=0)
	TEST_WORDCNT_TWO = models.SmallIntegerField(default=0)
	TEST_NUM_CONV	= models.SmallIntegerField(default=0)
	TEST_SUPERMARKET = models.SmallIntegerField(default=0)
	TEST_REVERSE = models.SmallIntegerField(default=0)
	TEST_REPEAT = models.SmallIntegerField(default=0)
	TEST_RESULT = models.SmallIntegerField(default=0)

	## DESCRIPTION
	TEST_PREDICT_SYMPTOM = models.TextField(default='NOR')
	TEST_ALERT_DATE = models.DateField()

	#### THESE ARE REMOVED BECAUSE OF FIXED LOCATION AT S3
	#TEST_REC_WORDCNT = models.TextField()     ## File Location
	#TEST_REC_SUPERMRK = models.TextField()
	#TEST_REC_REVERSE = models.TextField()
	#TEST_RECT_REPEAT = models.TextField()

	EXPERT_IDX = models.ForeignKey(Expert)

class SurveyResults(models.Model):
	SURV_IDX = models.IntegerField(primary_key = True)
	#SURV_DATE = models.IntegerField(validators[MaxValueValidator(99999999999999)])
	SURV_DATE = models.IntegerField()

	#PAT_IDX = models.ForeignKey(Patients, on_delete = models.CASCADE)
	
	SURV_COLIVE = models.BooleanField()
	SURV_QONE = models.TextField()

	### AFTER DESIGN PROCEDURE IS COMPLETED...


class Question(models.Model):
	### Set EXAMPLE WORD1/WORD2/WORD3/WORD4/.../WORD10/12/123/1234/12345/123456
	SET_IDX = models.IntegerField(primary_key=True)
	SET_FIRST = models.TextField()
	SET_SECOND = models.TextField()
	#SET_FOURTH_FIRST = models.TextField()
	#SET_FOURTH_SECOND = models.TextField()

class Observation(models.Model):
	PAT_IDX = models.ForeignKey(Patients, on_delete = models.CASCADE)
	OBS_DATE = models.DateTimeField()
	OBS_TYPE = models.SmallIntegerField()
	OBS_DURATION = models.SmallIntegerField()






