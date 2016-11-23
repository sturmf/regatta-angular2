import 'dart:async';
import 'dart:html' show window;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';

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
    /*
    final List<dynamic> link = [
      'EventDetail',
      {'id': event.id.toString()}
    ];
    _router.navigate(link);
    */
  }
}
