import 'package:angular_router/angular_router.dart';

import 'route_paths.dart';
import 'package:frontend/components/event_detail_component/event_detail_component.template.dart'
    as event_detail_template;
import 'package:frontend/components/event_list_component/event_list_component.template.dart' as event_list_template;
import 'package:frontend/components/sailing_club_detail_component/sailing_club_detail_component.template.dart'
    as sailing_club_detail_template;
import 'package:frontend/components/sailing_club_list_component/sailing_club_list_component.template.dart'
    as sailing_club_list_template;
import 'package:frontend/components/boat_detail_component/boat_detail_component.template.dart' as boat_detail_template;
import 'package:frontend/components/boat_list_component/boat_list_component.template.dart' as boat_list_template;

export 'route_paths.dart';

class Routes {
  static final RouteDefinition event =
      RouteDefinition(routePath: RoutePaths.event, component: event_detail_template.EventDetailComponentNgFactory);

  static final RouteDefinition events =
      RouteDefinition(routePath: RoutePaths.events, component: event_list_template.EventListComponentNgFactory);

  static final RouteDefinition sailingClub = RouteDefinition(
      routePath: RoutePaths.sailingClub, component: sailing_club_detail_template.SailingClubDetailComponentNgFactory);

  static final RouteDefinition sailingClubs = RouteDefinition(
      routePath: RoutePaths.sailingClubs, component: sailing_club_list_template.SailingClubListComponentNgFactory);

  static final RouteDefinition boat =
      RouteDefinition(routePath: RoutePaths.boat, component: boat_detail_template.BoatDetailComponentNgFactory);

  static final RouteDefinition boats =
      RouteDefinition(routePath: RoutePaths.boats, component: boat_list_template.BoatListComponentNgFactory);

  static final List<RouteDefinition> all = <RouteDefinition>[
    event,
    events,
    sailingClub,
    sailingClubs,
    boat,
    boats,
  ];
}
