import 'package:angular2/core.dart';
import 'package:angular2/platform/common.dart';
import 'package:angular2/router.dart';

import 'event_service.dart';
import 'event_list_component.dart';


@Component(
  selector: 'my-app',
  template: '''
    <h1>Regatta</h1>
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
  const Route(path: '/events', name: 'Events', component: EventListComponent, useAsDefault: true)
])
class AppComponent {
  AppComponent();
}

