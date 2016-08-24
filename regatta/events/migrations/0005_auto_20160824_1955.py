# -*- coding: utf-8 -*-
# Generated by Django 1.10 on 2016-08-24 19:55
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('events', '0004_auto_20160824_1952'),
    ]

    operations = [
        migrations.AlterField(
            model_name='entry',
            name='crew',
            field=models.ManyToManyField(blank=True, help_text='crew members', related_name='entries_crew_in', to='events.Person'),
        ),
        migrations.AlterField(
            model_name='event',
            name='assistants',
            field=models.ManyToManyField(blank=True, help_text='everybody else helping in the event', related_name='events_assisting_in', to='events.Person'),
        ),
    ]