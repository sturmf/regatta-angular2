from django.test import TestCase
from datetime import date
from .models import Event


class EventTests(TestCase):

    def test_event_defaults(self):
        """
        checks if the default values are set after creation of an event
        """
        event = Event()
        self.assertIs(event.name, '')
        self.assertIs(event.mode, Event.YARDSTICK)
        self.assertEqual(event.start_date, date.today())
        self.assertEqual(event.end_date, date.today())
        self.assertIs(event.race_count, 1)
