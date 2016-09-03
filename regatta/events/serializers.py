from rest_framework import serializers
from .models import Event
from .models import SailingClub


class EventSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Event
        fields = ('name', 'mode', 'start_date', 'end_date', 'race_count', 'race_unrated_on', 'organizer')
        # fields = ('name', 'mode', 'start_date', 'end_date', 'race_count', 'race_unrated_on', 'organizer', 'race_committee', 'umpire')


class SailingClubSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = SailingClub
        fields = ('name',)
