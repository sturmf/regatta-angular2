from rest_framework import viewsets
from .models import Event
from .models import SailingClub
from .models import Person
from .serializers import EventSerializer
from .serializers import SailingClubSerializer
from .serializers import PersonSerializer


class EventViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows events to be viewed or edited.
    """
    queryset = Event.objects.all().order_by('-start_date')
    serializer_class = EventSerializer


class SailingClubViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows sailing_clubs to be viewed or edited.
    """
    queryset = SailingClub.objects.all().order_by('name')
    serializer_class = SailingClubSerializer


class PersonViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows sailing_clubs to be viewed or edited.
    """
    queryset = Person.objects.all().order_by('first_name')
    serializer_class = PersonSerializer
