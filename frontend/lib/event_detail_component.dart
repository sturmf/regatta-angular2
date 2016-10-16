import 'dart:async';
import 'dart:html' show window;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'event_assistants_list_component.dart';
import 'models/event.dart';
import 'models/sailing_club.dart';
import 'models/person.dart';
import 'package:frontend/services/event_service.dart';
import 'package:frontend/services/person_service.dart';


@Component(
    selector: 'my-event-detail',
    templateUrl: 'event_detail_component.html',
    styleUrls: const ['event_detail_component.css'],
    directives: const [EventAssistantsListComponent]
)
class EventDetailComponent implements OnInit {
  Event event;
  List<SailingClub> sailing_clubs;
  List<Person> persons;

  Future<List<Person>> getPersons([String search='']) async => _personService.getAll(search != '' ? {'search': search} : null);

  final EventService _eventService;
  final PersonService _personService;
  final Router _router;
  final RouteParams _routeParams;

  EventDetailComponent(this._eventService, this._router, this._routeParams, this._personService);

  ngOnInit() async {
    var id = int.parse(_routeParams.get('id'));
    event = await (_eventService.getEvent(id));
    sailing_clubs = await (_eventService.getSailingClubs());
    persons = await (_personService.getAll());
  }

  Future<Null> onSubmit() async {
    await _eventService.update(event);
    goBack();
  }

  goBack() {
    window.history.back();
  }

  addAssistant(person) {
    print("add requested");
    event.assistants.add(person);
    // FIXME: the following is a workaround so that the
    // EventAssistantsListComponent detects the changed assistants,
    // the add() alone does not trigger this
    // event.assistants = event.assistants.toList();
  }

  deleteAssistant(assistant) {
    print("delete requested");
    event.assistants.remove(assistant);
    // FIXME: the following is a workaround so that the
    // EventAssistantsListComponent detects the changed assistants,
    // the remove() alone does not trigger this
    // event.assistants = event.assistants.toList();
  }

}
