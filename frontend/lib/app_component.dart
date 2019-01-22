import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_components/angular_components.dart';

import 'package:frontend/routes.dart';
import 'package:frontend/components/navigation_bar_component/navigation_bar_component.dart';
import 'package:frontend/store/regatta_store.dart';
import 'package:frontend/services/firebase_service.dart';
import 'package:frontend/services/database_service.dart';

@Component(selector: 'my-app', templateUrl: 'app_component.html',
    styleUrls: const [
    'app_component.css',
    'package:angular_components/app_layout/layout.scss.css'
  ], directives: [
  coreDirectives,
  routerDirectives,
  DeferredContentDirective,
  MaterialButtonComponent,
  MaterialIconComponent,
  MaterialPersistentDrawerDirective,
  NavigationBarComponent
],
    providers: [
      materialProviders,
      ClassProvider(LocationStrategy, useClass: HashLocationStrategy),
      RegattaStore,
      FirebaseService,
      DatabaseService,
    ],
    exports: [RoutePaths, Routes]
)
class AppComponent {
  final FirebaseService fbService;
  final DatabaseService databaseService;

  static Injector myinjector;

  String branch = const String.fromEnvironment('branch', defaultValue: 'Unknown');
  String hash = const String.fromEnvironment('hash', defaultValue: '');

  AppComponent(this.fbService, this.databaseService);
}
