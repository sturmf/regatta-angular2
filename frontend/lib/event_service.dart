import 'package:angular2/core.dart';

import 'event.dart';

final List<Event> mockEvents = [
    new Event(1, 'Bayerische Jugendwoche'),
    new Event(2, 'Lasercup'),
];

@Injectable()
class EventService {
  List<Event> getEvents() => mockEvents;
}
