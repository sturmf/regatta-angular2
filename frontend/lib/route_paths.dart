import 'package:angular_router/angular_router.dart';

const String keyParam = 'key';

class RoutePaths {
  static final RoutePath events = RoutePath(path: 'events', useAsDefault: true);
  static final RoutePath event = RoutePath(path: '${events.path}/:$keyParam');
  static final RoutePath sailingClubs = RoutePath(path: 'sailingclubs');
  static final RoutePath sailingClub = RoutePath(path: '${sailingClubs.path}/:$keyParam');
  static final RoutePath boats = RoutePath(path: 'boats');
  static final RoutePath boat = RoutePath(path: '${boats.path}/:$keyParam');
}
