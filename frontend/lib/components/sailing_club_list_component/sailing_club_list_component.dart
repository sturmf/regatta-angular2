import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_components/angular_components.dart';
import 'package:frontend/routes.dart';
import 'package:frontend/store/regatta_store.dart';

import 'package:frontend/models/sailing_club.dart';

@Component(
    selector: 'my-sailing-club-list',
    templateUrl: 'sailing_club_list_component.html',
    styleUrls: const ['sailing_club_list_component.css'],
    directives: const [coreDirectives, materialInputDirectives, MaterialButtonComponent, MaterialIconComponent],
    providers: const [materialProviders])
class SailingClubListComponent {
  SailingClubListComponent(this._router, this._store);

  String sailingClubName = '';

  final Router _router;
  final RegattaStore _store;

  Iterable<SailingClub> get sailingClubs => _store.state.sailingClubs.values;

  void addNewSailingClubHandler() {
    if (sailingClubName.length > 0) {
      _store.dispatch(_store.action.requestCreateSailingClub(sailingClubName));
      sailingClubName = '';
    }
  }

  void deleteSailingClubHandler(SailingClub sailingClub) {
    _store.dispatch(_store.action.requestDeleteSailingClub(sailingClub));
  }

  void gotoSailingClub(SailingClub sailingClub) {
    _router.navigate(RoutePaths.sailingClub.toUrl(parameters: {'key': sailingClub.key}));
  }
}
