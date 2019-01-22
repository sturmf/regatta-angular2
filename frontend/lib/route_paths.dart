import 'package:angular_router/angular_router.dart';

const keyParam = 'key';

class RoutePaths {

  static final events = RoutePath(path: 'events', useAsDefault: true);
  static final event = RoutePath(path: '${events.path}/:$keyParam');
  static final sailingClubs = RoutePath(path: 'sailingclubs');
  static final sailingClub = RoutePath(path: '${sailingClubs.path}/:$keyParam');
  static final boats = RoutePath(path: 'boats');
  static final boat = RoutePath(path: '${boats.path}/:$keyParam');

}
