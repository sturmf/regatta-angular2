from django.contrib import admin
from .models import Event
from .models import Person
from .models import SailingClub
from .models import BoatType
from .models import Entry

admin.site.register(Event)
admin.site.register(Person)
admin.site.register(SailingClub)
admin.site.register(BoatType)
admin.site.register(Entry)
