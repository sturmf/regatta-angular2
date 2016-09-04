from rest_framework import serializers
from .models import Event
from .models import SailingClub
from .models import Person


class SailingClubSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = SailingClub
        fields = ('url', 'name', 'abbreviation', 'registration', 'was_organizer')


class PersonSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Person
        fields = ('url', 'first_name', 'last_name', 'sailing_club')


class EventSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Event
        fields = ('url', 'name', 'mode', 'start_date', 'end_date', 'race_count', 'race_unrated_on', 'organizer', 'race_committee', 'umpire', 'assistants')
