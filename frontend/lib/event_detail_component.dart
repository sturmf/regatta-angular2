import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'event_service.dart';
import 'event.dart';

@Component(
  selector: 'my-event-detail',
  templateUrl: 'event_detail_component.html',
  styleUrls: const ['event_detail_component.css']
)
class EventDetailComponent implements OnInit {
  Event event;

  final EventService _eventService;
  final RouteParams _routeParams;

  EventDetailComponent(this._eventService, this._routeParams);

  ngOnInit() async {
    var id = int.parse(_routeParams.get('id'));
    event = await (_eventService.getEvent(id));
  }

  goBack() {
    window.history.back();
  }

}
