import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:frontend/store/RegattaStore.dart';

import 'models/event.dart';

@Component(
    selector: 'my-event-list',
    templateUrl: 'event_list_component.html',
    styleUrls: const ['event_list_component.css'],
    directives: const [materialDirectives],
    //changeDetection: ChangeDetectionStrategy.OnPush,
    providers: const [materialProviders])
class EventListComponent {
  final Router _router;
  final RegattaStore _store;

  EventListComponent(this._router, this._store);

  Iterable<Event> get events =>_store.store.state.events as Iterable<Event>;

  void addNewEventHandler(String name) {
    _store.store.dispatch(addNewEvent(name));
  }

  // FIXME: rewrite as redux change
  void gotoEvent(Event event) {
    final List<dynamic> link = [
      'EventDetail',
      {'id': event.id.toString()}
    ];
    _router.navigate(link);
  }


}
