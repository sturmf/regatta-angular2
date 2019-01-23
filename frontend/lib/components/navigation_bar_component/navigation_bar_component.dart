import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_components/angular_components.dart';

import 'package:frontend/routes.dart';

@Component(
    selector: 'my-navigation-bar',
    templateUrl: 'navigation_bar_component.html',
    styleUrls: const ['navigation_bar_component.css'],
    directives: const [MaterialListItemComponent, MaterialIconComponent],
    providers: const [materialProviders])
class NavigationBarComponent implements OnInit {
  NavigationBarComponent(this._router);

  final Router _router;

  @override
  void ngOnInit() {}

  void gotoLink(String dest) {
    // FIXME: shouldn't these be events and the event itself does the routing?
    switch (dest) {
      case 'events':
        _router.navigate(RoutePaths.events.toUrl());
        break;
      case 'boats':
        _router.navigate(RoutePaths.boats.toUrl());
        break;
      case 'sailingclubs':
        _router.navigate(RoutePaths.sailingClubs.toUrl());
        break;
      case 'settings':
        print("Settings URL not implemented");
        // FIXME: _router.navigate(RoutePaths.settings.toUrl());
        break;
    }
  }
}
