from rest_framework import serializers
from .models import SailingClub
from .models import Person
from .models import Event
from .models import BoatType
from .models import Entry
from .models import Race


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


class BoatTypeSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = BoatType
        fields = ('url', 'name', 'yardstick')


class EntrySerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Entry
        fields = ('url', 'event', 'helm', 'crew', 'boat_type')


class RaceSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Race
        fields = ('url', 'event', 'number', 'start_time', 'end_time', 'sky_condition', 'wind_speed_min', 'wind_speed_max', 'placements')
