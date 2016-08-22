from datetime import date
from django.db import models

class Person(models.Model):
    first_name = models.CharField(max_length=200, blank=True)
    last_name = models.CharField(max_length=200, blank=True)

    def __str__(self):
        return '%s %s' % (self.first_name, self.last_name)



class SailingClub(models.Model):
    name = models.CharField(max_length=200, blank=True, help_text="full name of the sailing club")
    abbreviation = models.CharField(max_length=20, blank=True, help_text="official abbreviation of the sailing club")
    registration = models.CharField(max_length=20, blank=True, help_text="the registration number of the sailing club, if applicable")
    was_organizer = models.BooleanField(default=False, help_text="if this sailing club has ever been an organizer")

    def __str__(self):
        return self.name


class Event(models.Model):
      
    YARDSTICK = 1
    CLASS = 2
    MODE_CHOICES = (
        (YARDSTICK, 'Yardstick'),
        (CLASS, 'Class'),
    )

    name = models.CharField(max_length=200, blank=True, help_text="name of the event")
    mode = models.IntegerField(choices=MODE_CHOICES, default=YARDSTICK, help_text="type of the event either Class or Yardstick")
    start_date = models.DateField(default=date.today, help_text="first day of the event")
    end_date = models.DateField(default=date.today, help_text="last day of the event")
    race_count = models.PositiveIntegerField(default=1, help_text="amount of races scheduled during the event")
    organizer = models.ForeignKey(SailingClub, help_text="the sailing club that organizes the event")
    race_committee = models.ForeignKey(Person, help_text="the person responsible for the execution of the event")

    def __str__(self):
        return self.name
