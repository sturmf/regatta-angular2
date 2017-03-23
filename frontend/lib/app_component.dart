import 'package:angular2/core.dart';
import 'package:angular2/platform/common.dart';
import 'package:angular2/router.dart';

import 'package:frontend/components/app_header/app_header.dart';
import 'package:frontend/components/event_list_component/event_list_component.dart';
import 'package:frontend/components/event_detail_component/event_detail_component.dart';
import 'package:frontend/components/navigation_bar_component/navigation_bar_component.dart';
import 'package:frontend/components/sailing_club_list_component/sailing_club_list_component.dart';
import 'package:frontend/components/sailing_club_detail_component/sailing_club_detail_component.dart';
import 'package:frontend/components/boat_list_component/boat_list_component.dart';
import 'package:frontend/components/boat_detail_component/boat_detail_component.dart';
import 'package:frontend/store/regatta_store.dart';
import 'package:frontend/services/firebase_service.dart';

@Component(selector: 'my-app', templateUrl: 'app_component.html', styleUrls: const [
  'app_component.css'
], directives: const [
  ROUTER_DIRECTIVES,
  AppHeader,
  NavigationBarComponent
],
    //changeDetection: ChangeDetectionStrategy.OnPush,
    providers: const [
      ROUTER_PROVIDERS,
      const Provider(LocationStrategy, useClass: HashLocationStrategy),
      RegattaStore,
      FirebaseService,
    ])
@RouteConfig(const [
  const Route(path: '/events', name: 'Events', component: EventListComponent, useAsDefault: true),
  const Route(path: '/sailingclubs', name: 'SailingClubs', component: SailingClubListComponent),
  const Route(path: '/boats', name: 'Boats', component: BoatListComponent),
  const Route(path: '/event/:key', name: 'EventDetail', component: EventDetailComponent),
  const Route(path: '/sailing_club/:key', name: 'SailingClubDetail', component: SailingClubDetailComponent),
  const Route(path: '/boat/:key', name: 'BoatDetail', component: BoatDetailComponent)
])
class AppComponent {
  static Injector myinjector;
  String branch = const String.fromEnvironment('branch', defaultValue: 'Unknown');
  String hash = const String.fromEnvironment('hash', defaultValue: '');
}
