import 'package:angular2/core.dart';
//import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';

import 'package:frontend/components/event_assistants_list_component/event_assistants_list_component.dart';
import 'package:frontend/store/regatta_store.dart';
import 'package:frontend/models/event.dart';

@Component(
    selector: 'my-event-detail',
    templateUrl: 'event_detail_component.html',
    styleUrls: const ['event_detail_component.css'],
    directives: const [materialDirectives, EventAssistantsListComponent],
    providers: const [materialProviders])
class EventDetailComponent /*implements OnInit*/ {
  // final Router _router;
  // final RouteParams _routeParams;
  final RegattaStore _store;

  EventDetailComponent(/* this._router, this._routeParams*/ this._store);

  //Event get event => _store.state.selectedEvent;
  Event get event {
    print('loadind selected event ${_store.state.selectedEvent}');
    return _store.state.selectedEvent;
  }
}
