from django.contrib import admin
from .models import Event
from .models import Person
from .models import SailingClub
from .models import BoatType
from .models import Entry


class EntryAdmin(admin.ModelAdmin):
    model = Entry
    list_display = ('event', 'helm', 'crew_names', 'boat_type')


admin.site.register(Event)
admin.site.register(Person)
admin.site.register(SailingClub)
admin.site.register(BoatType)
admin.site.register(Entry, EntryAdmin)
