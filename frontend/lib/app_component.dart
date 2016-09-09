import 'package:angular2/core.dart';
import 'package:angular2/platform/common.dart';
import 'package:angular2/router.dart';

import 'event_service.dart';


@Component(
  selector: 'my-app',
  template: '''
    <h1>My First Angular 2 App</h1>
    <div *ngFor="let event of events">
      <div>
        <h4>{{event.name}}</h4>
      </div>
    </div>
    ''',
  directives: const [
    ROUTER_DIRECTIVES
  ],
  providers: const [
    ROUTER_PROVIDERS,
    const Provider(LocationStrategy, useClass: HashLocationStrategy),
    EventService
  ]
)


class AppComponent implements OnInit {
  final EventService _eventService;
  List<Event> events;

  AppComponent(this._eventService);

  ngOnInit() async => events  = (await _eventService.getEvents());

}

