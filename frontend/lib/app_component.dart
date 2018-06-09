import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_components/angular_components.dart';

import 'package:frontend/components/event_list_component/event_list_component.dart';
import 'package:frontend/components/event_detail_component/event_detail_component.dart';
import 'package:frontend/components/navigation_bar_component/navigation_bar_component.dart';
import 'package:frontend/components/sailing_club_list_component/sailing_club_list_component.dart';
import 'package:frontend/components/sailing_club_detail_component/sailing_club_detail_component.dart';
import 'package:frontend/components/boat_list_component/boat_list_component.dart';
import 'package:frontend/components/boat_detail_component/boat_detail_component.dart';
import 'package:frontend/store/regatta_store.dart';
import 'package:frontend/services/firebase_service.dart';
import 'package:frontend/services/database_service.dart';

@Component(selector: 'my-app', templateUrl: 'app_component.html', styleUrls: const [
  'package:angular_components/src/components/app_layout/layout.scss.css',
  'app_component.css'
], directives: const [
  CORE_DIRECTIVES,
  ROUTER_DIRECTIVES,
  MaterialPersistentDrawerDirective,
  materialDirectives,
  NavigationBarComponent
],
    //changeDetection: ChangeDetectionStrategy.OnPush,
    providers: const [
      ROUTER_PROVIDERS,
      materialProviders,
      const Provider(LocationStrategy, useClass: HashLocationStrategy),
      RegattaStore,
      FirebaseService,
      DatabaseService
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
  final FirebaseService fbService;
  final DatabaseService databaseService;

  static Injector myinjector;
  String branch = const String.fromEnvironment('branch', defaultValue: 'Unknown');
  String hash = const String.fromEnvironment('hash', defaultValue: '');

  AppComponent(this.fbService, this.databaseService);
}
