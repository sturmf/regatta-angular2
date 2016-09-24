import 'package:angular2/core.dart';
import 'package:angular2/platform/common.dart';
import 'package:angular2/router.dart';

import 'event_service.dart';
import 'event_list_component.dart';
import 'event_detail_component.dart';


@Component(
  selector: 'my-app',
  template: '''
    <h1 align="center">Fail this Test</h1>
    <router-outlet></router-outlet>
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
@RouteConfig(const [
  const Route(path: '/events', name: 'Events', component: EventListComponent, useAsDefault: true),
  const Route(path: '/event/:id', name: 'EventDetail', component: EventDetailComponent)
])
class AppComponent {
  AppComponent();
}

