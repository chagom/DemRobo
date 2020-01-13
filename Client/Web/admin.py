from django.contrib import admin
from .models import Patients
from .models import Expert
from .models import CareGiver
from .models import TestResults
from .models import SurveyResults
from .models import Question

admin.site.register(Patients)
admin.site.register(Expert)
admin.site.register(Question)
admin.site.register(TestResults)
