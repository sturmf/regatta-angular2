from django.contrib import admin
from .models import Event
from .models import Person
from .models import SailingClub
from .models import BoatType
from .models import Entry


class EventAdmin(admin.ModelAdmin):
    model = Event
    list_display = ('name', 'mode', 'start_date', 'end_date', 'race_count', 'race_unrated_on', 'organizer', 'race_committee', 'umpire')


class EntryAdmin(admin.ModelAdmin):
    model = Entry
    list_display = ('event', 'helm', 'crew_names', 'boat_type')


admin.site.register(Event, EventAdmin)
admin.site.register(Person)
admin.site.register(SailingClub)
admin.site.register(BoatType)
admin.site.register(Entry, EntryAdmin)
