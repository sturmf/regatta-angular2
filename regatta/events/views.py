from rest_framework import viewsets
from .models import SailingClub
from .models import Person
from .models import Event
from .models import BoatType
from .models import Entry
from .models import Race
from .serializers import SailingClubSerializer
from .serializers import PersonSerializer
from .serializers import EventSerializer
from .serializers import BoatTypeSerializer
from .serializers import EntrySerializer
from .serializers import RaceSerializer


class SailingClubViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows sailing clubs to be viewed or edited.
    """
    queryset = SailingClub.objects.all().order_by('name')
    serializer_class = SailingClubSerializer


class PersonViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows persons to be viewed or edited.
    """
    queryset = Person.objects.all().order_by('first_name')
    serializer_class = PersonSerializer


class EventViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows events to be viewed or edited.
    """
    queryset = Event.objects.all().order_by('-start_date')
    serializer_class = EventSerializer


class BoatTypeViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows boat types to be viewed or edited.
    """
    queryset = BoatType.objects.all().order_by('name')
    serializer_class = BoatTypeSerializer


class EntryViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows entries to be viewed or edited.
    """
    queryset = Entry.objects.all().order_by('event__name', 'helm__first_name')
    serializer_class = EntrySerializer


class RaceViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows races to be viewed or edited.
    """
    queryset = Race.objects.all().order_by('event__name', 'number')
    serializer_class = RaceSerializer
