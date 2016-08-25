# -*- coding: utf-8 -*-
# Generated by Django 1.10 on 2016-08-25 05:46
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('events', '0005_auto_20160824_1955'),
    ]

    operations = [
        migrations.AddField(
            model_name='person',
            name='sailing_club',
            field=models.ForeignKey(help_text='member of this sailing club', null=True, on_delete=django.db.models.deletion.CASCADE, to='events.SailingClub'),
        ),
    ]
