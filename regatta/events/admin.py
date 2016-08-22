from django.contrib import admin
from .models import Event
from .models import Person
from .models import SailingClub

admin.site.register(Event)
admin.site.register(Person)
admin.site.register(SailingClub)

