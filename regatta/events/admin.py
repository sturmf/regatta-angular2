from django.contrib import admin
from .models import Event
from .models import Person
from .models import SailingClub
from .models import BoatType
from .models import Entry
from .models import Race


class EventAdmin(admin.ModelAdmin):
    model = Event
    list_display = ('name', 'mode', 'start_date', 'end_date', 'race_count', 'race_unrated_on', 'organizer', 'race_committee', 'umpire')


class EntryAdmin(admin.ModelAdmin):
    model = Entry
    list_display = ('event', 'helm', 'crew_names', 'boat_type')


class PlacementInline(admin.TabularInline):
    model = Race.placements.through
    fields = ('entry', 'finish_position', 'finish_time', 'calculated_time', 'status')
    readonly_fields = ('calculated_time',)


class RaceAdmin(admin.ModelAdmin):
    model = Race
    list_display = ('event', 'number', 'start_time', 'end_time', 'sky_condition', 'wind_speed_min', 'wind_speed_max')
    inlines = [
        PlacementInline,
    ]

admin.site.register(Event, EventAdmin)
admin.site.register(Person)
admin.site.register(SailingClub)
admin.site.register(BoatType)
admin.site.register(Entry, EntryAdmin)
admin.site.register(Race, RaceAdmin)
