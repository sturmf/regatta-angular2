from rest_framework import serializers
from .models import SailingClub
from .models import Person
from .models import Event
from .models import BoatType
from .models import Entry
from .models import Race
from .models import Placement


class SailingClubSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = SailingClub
        fields = ('url', 'name', 'abbreviation', 'registration', 'was_organizer')


class PersonSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Person
        fields = ('url', 'first_name', 'last_name', 'sailing_club')


class EventSerializer(serializers.HyperlinkedModelSerializer):
    entry_set = serializers.HyperlinkedRelatedField(many=True, read_only=True, view_name='entry-detail')

    class Meta:
        model = Event
        fields = ('url', 'name', 'mode', 'start_date', 'end_date', 'race_count', 'race_unrated_on',
                  'organizer', 'race_committee', 'umpire', 'assistants', 'entry_set')  # what about races


class BoatTypeSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = BoatType
        fields = ('url', 'name', 'yardstick')


class EntrySerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Entry
        fields = ('url', 'event', 'helm', 'crew', 'boat_type')


class PlacementSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Placement
        fields = ('url', 'race', 'entry', 'finish_position', 'finish_time', 'calculated_time', 'status')


class RaceSerializer(serializers.HyperlinkedModelSerializer):
    placement_set = serializers.HyperlinkedRelatedField(many=True, read_only=True, view_name='placement-detail')

    class Meta:
        model = Race
        fields = ('url', 'event', 'number', 'start_time', 'end_time', 'sky_condition', 'wind_speed_min', 'wind_speed_max', 'placement_set')
