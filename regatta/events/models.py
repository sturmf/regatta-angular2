from datetime import date
from django.db import models


class SailingClub(models.Model):
    name = models.CharField(max_length=200, blank=True, help_text='full name of the sailing club')
    abbreviation = models.CharField(max_length=20, blank=True, help_text='official abbreviation of the sailing club')
    registration = models.CharField(max_length=20, blank=True, help_text='the registration number of the sailing club, if applicable')
    was_organizer = models.BooleanField(default=False, help_text='if this sailing club has ever been an organizer')

    def __str__(self):
        return self.name


class Person(models.Model):
    first_name = models.CharField(max_length=200, blank=True)
    last_name = models.CharField(max_length=200, blank=True)
    sailing_club = models.ForeignKey(SailingClub, null=True, help_text='member of this sailing club')

    def __str__(self):
        return '%s %s, %s' % (self.first_name, self.last_name, self.sailing_club.abbreviation if self.sailing_club else '')


class Event(models.Model):

    MODE_YARDSTICK = 1
    MODE_CLASS = 2
    MODE_CHOICES = (
        (MODE_YARDSTICK, 'Yardstick'),
        (MODE_CLASS, 'Class'),
    )

    name = models.CharField(max_length=200, blank=True, help_text='name of the event')
    mode = models.IntegerField(choices=MODE_CHOICES, default=MODE_YARDSTICK, help_text='type of the event either Class or Yardstick')
    start_date = models.DateField(default=date.today, help_text='first day of the event')
    end_date = models.DateField(default=date.today, help_text='last day of the event')
    race_count = models.PositiveIntegerField(default=1, help_text='amount of races scheduled during the event')
    race_unrated_on = models.CharField(max_length=100, blank=True, help_text='describing after how many race one is unaccounted for e.g. "4,7"')
    organizer = models.ForeignKey(SailingClub, null=True, help_text='the sailing club that organizes the event')
    race_committee = models.ForeignKey(Person, null=True, related_name='events_race_committee_in',
                                       help_text='the person responsible for the execution of the event')
    umpire = models.ForeignKey(Person, null=True, related_name='events_umpire_in', help_text='the presiding judge')
    assistants = models.ManyToManyField(Person, blank=True, related_name='events_assisting_in', help_text='everybody else helping in the event')

    def __str__(self):
        return self.name


class BoatType(models.Model):
    name = models.CharField(max_length=200, blank=True, help_text='name of the boat type')
    yardstick = models.PositiveIntegerField(default=0, help_text='official yardstick value')

    def __str__(self):
        return self.name


class Entry(models.Model):
    event = models.ForeignKey(Event, null=False, help_text='event this entry is part of')
    helm = models.ForeignKey(Person, null=True, help_text='person steering')
    crew = models.ManyToManyField(Person, blank=True, related_name='entries_crew_in', help_text='crew members')
    boat_type = models.ForeignKey(BoatType, null=True, help_text='the boat type used by this entry')

    def __str__(self):
        return '%s on %s' % (self.helm, self.boat_type)

    def crew_names(self):
        crew_names = [str(member) for member in self.crew.all()]
        return ' / '.join(crew_names)


class Race(models.Model):

    SKY_CONDITION_CLOUDY = 1
    SKY_CONDITION_MOSTLY_CLOUDY = 2
    SKY_CONDITION_PARTLY_SUNNY = 3
    SKY_CONDITION_MOSTLY_SUNNY = 4
    SKY_CONDITION_SUNNY = 5

    SKY_CONDITION_CHOICES = (
        (SKY_CONDITION_CLOUDY, 'cloudy'),
        (SKY_CONDITION_MOSTLY_CLOUDY, 'mostly cloudy'),
        (SKY_CONDITION_PARTLY_SUNNY, 'partly sunny'),
        (SKY_CONDITION_MOSTLY_SUNNY, 'mostly sunny'),
        (SKY_CONDITION_SUNNY, 'sunny'),
    )

    event = models.ForeignKey(Event, null=False, help_text='event this race is part of')
    number = models.PositiveIntegerField(help_text='number of race in an event')
    start_time = models.DateTimeField(help_text='start of the race')
    end_time = models.DateTimeField(help_text='end of the race')
    sky_condition = models.IntegerField(choices=SKY_CONDITION_CHOICES, help_text='weather during the race')
    wind_speed_min = models.PositiveIntegerField(help_text='minimum wind speed during the race in beaufort')
    wind_speed_max = models.PositiveIntegerField(help_text='maximum wind speed during the race in beaufort')
    placements = models.ManyToManyField(Entry, through='RaceEntryRelationship')

    class Meta:
        unique_together = ("event", "number")

    def __str__(self):
        return 'race number %s of %s' % (self.number, self.event.name)


class RaceEntryRelationship(models.Model):

    RACE_STATUS_NONE = 1
    RACE_STATUS_DNC = 2
    RACE_STATUS_DNF = 3
    RACE_STATUS_OCS = 4

    RACE_STATUS_CHOICES = (
        (RACE_STATUS_NONE, ''),
        (RACE_STATUS_DNC, 'DNC'),
        (RACE_STATUS_DNF, 'DNF'),
        (RACE_STATUS_OCS, 'OCS'),
    )

    race = models.ForeignKey(Race)
    entry = models.ForeignKey(Entry)
    finish_position = models.PositiveIntegerField(blank=True, null=True, help_text='position in which the finish line was crossed')
    finish_time = models.DateTimeField(blank=True, null=True, help_text='time the boat crossed the finish line')
    calculated_time = models.DateTimeField(blank=True, null=True, help_text='the calculated time depending on the yardstick number')
    status = models.IntegerField(choices=RACE_STATUS_CHOICES, default=RACE_STATUS_NONE, help_text='special race finishing status')

    class Meta:
        unique_together = ("race", "entry")
