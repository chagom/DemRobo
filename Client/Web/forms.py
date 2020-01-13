from django import forms
from .models import Expert
from django.forms import ModelForm, TextInput

class ExpertForm(forms.ModelForm):
	
	class Meta:
		model = Expert
		fields = ('EXPERT_ID', 'EXPERT_PW')
		widgets = {
			'EXPERT_ID' : TextInput(attrs={'class':'form-control'}),
			'EXPERT_PW' : TextInput(attrs={'class':'form-control'}),
		}

	def clean_EXPERT_ID(self):
		userID = self.cleaned_data.get('EXPERT_ID')
		return userID

	def clean_EXPERT_PW(self):
		userPW = self.cleaned_data.get('EXPERT_PW')
		return userPW

