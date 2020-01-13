# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='CareGiver',
            fields=[
                ('CARE_IDX', models.IntegerField(serialize=False, primary_key=True)),
                ('CARE_ID', models.TextField(max_length=15)),
                ('CARE_PW', models.TextField(max_length=15)),
            ],
        ),
        migrations.CreateModel(
            name='Expert',
            fields=[
                ('EXPERT_IDX', models.IntegerField(serialize=False, primary_key=True)),
                ('EXPERT_ID', models.TextField(max_length=15)),
                ('EXPERT_PW', models.TextField(max_length=20)),
            ],
        ),
        migrations.CreateModel(
            name='Observation',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('OBS_DATE', models.DateTimeField()),
                ('OBS_TYPE', models.SmallIntegerField()),
                ('OBS_DURATION', models.SmallIntegerField()),
            ],
        ),
        migrations.CreateModel(
            name='Patients',
            fields=[
                ('PAT_IDX', models.IntegerField(serialize=False, primary_key=True)),
                ('PAT_NAME', models.TextField(max_length=50)),
                ('PAT_BIRTH', models.TextField(max_length=8)),
                ('PAT_PHONE', models.TextField(max_length=10)),
                ('PAT_EDUCATION', models.IntegerField()),
                ('PAT_HOSPITAL', models.TextField(max_length=100)),
                ('PAT_RECENT', models.TextField(max_length=14)),
                ('PAT_ID', models.TextField(max_length=15)),
                ('PAT_PW', models.TextField(default='0000', max_length=100)),
                ('PAT_CHARGE', models.IntegerField(default=1)),
                ('PAT_STATE', models.CharField(default='NOR', max_length=3, choices=[('NOR', 'Normal State'), ('MCI', 'Mild Cognitive Disorder'), ('SUS', 'Suspicious State')])),
            ],
        ),
        migrations.CreateModel(
            name='Question',
            fields=[
                ('SET_IDX', models.IntegerField(serialize=False, primary_key=True)),
                ('SET_FIRST', models.TextField()),
                ('SET_SECOND', models.TextField()),
            ],
        ),
        migrations.CreateModel(
            name='SurveyResults',
            fields=[
                ('SURV_IDX', models.IntegerField(serialize=False, primary_key=True)),
                ('SURV_DATE', models.IntegerField()),
                ('SURV_COLIVE', models.BooleanField()),
                ('SURV_QONE', models.TextField()),
            ],
        ),
        migrations.CreateModel(
            name='TestResults',
            fields=[
                ('TEST_IDX', models.IntegerField(serialize=False, primary_key=True)),
                ('TEST_SET', models.SmallIntegerField()),
                ('TEST_FOURTH_SET', models.TextField()),
                ('TEST_WORDCNT_ONE', models.SmallIntegerField(default=0)),
                ('TEST_WORDCNT_TWO', models.SmallIntegerField(default=0)),
                ('TEST_NUM_CONV', models.SmallIntegerField(default=0)),
                ('TEST_SUPERMARKET', models.SmallIntegerField(default=0)),
                ('TEST_REVERSE', models.SmallIntegerField(default=0)),
                ('TEST_REPEAT', models.SmallIntegerField(default=0)),
                ('TEST_RESULT', models.SmallIntegerField(default=0)),
                ('TEST_PREDICT_SYMPTOM', models.TextField(default='NOR')),
                ('TEST_ALERT_DATE', models.DateField()),
                ('EXPERT_IDX', models.ForeignKey(to='demrobo.Expert')),
                ('PAT_IDX', models.ForeignKey(to='demrobo.Patients')),
            ],
        ),
        migrations.AddField(
            model_name='observation',
            name='PAT_IDX',
            field=models.ForeignKey(to='demrobo.Patients'),
        ),
    ]
