import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_components/angular_components.dart';

@Component(
    selector: 'my-navigation-bar',
    templateUrl: 'navigation_bar_component.html',
    styleUrls: const ['navigation_bar_component.css'],
    directives: const [materialDirectives],
    providers: const [materialProviders])
class NavigationBarComponent implements OnInit {
  final Router _router;

  NavigationBarComponent(this._router);

  @override
  void ngOnInit() {}

  void gotoLink(String dest) {
    print(dest);
    // FIXME: shouldn't these be events and the event itself does the routing?
    _router.navigate([dest]);
  }
}
