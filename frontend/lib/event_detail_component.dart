import 'dart:async';
import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'event_service.dart';
import 'event.dart';
import 'sailing_club.dart';
import 'person.dart';


@Component(
  selector: 'my-event-detail',
  templateUrl: 'event_detail_component.html',
  styleUrls: const ['event_detail_component.css']
)
class EventDetailComponent implements OnInit {
  Event event;
  List<SailingClub> sailing_clubs;
  List<Person> persons;

  final EventService _eventService;
  final Router _router;
  final RouteParams _routeParams;

  EventDetailComponent(this._eventService, this._router, this._routeParams);

  ngOnInit() async {
    var id = int.parse(_routeParams.get('id'));
    event = await (_eventService.getEvent(id));
    sailing_clubs = await (_eventService.getSailingClubs());
    persons = await (_eventService.getPersons());
  }

  Future<Null> onSubmit() async {
    await _eventService.update(event);
    goBack();
  }

  goBack() {
    window.history.back();
  }

}
