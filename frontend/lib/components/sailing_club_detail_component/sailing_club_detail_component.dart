import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_components/angular_components.dart';

import 'package:frontend/store/regatta_store.dart';
import 'package:frontend/store/regatta_action.dart';
import 'package:frontend/models/sailing_club.dart';

@Component(
    selector: 'my-sailing-club-detail',
    templateUrl: 'sailing_club_detail_component.html',
    styleUrls: const ['sailing_club_detail_component.css'],
    directives: const [CORE_DIRECTIVES, materialDirectives],
    providers: const [materialProviders])
class SailingClubDetailComponent {
  final RegattaStore _store;
  final RouteParams _routeParams;
  String selectedSailingClub;

  SailingClubDetailComponent(this._store, this._routeParams) {
    selectedSailingClub = _routeParams.get('key');
  }

  SailingClub get sailingClub => _store.state.sailingClubs[selectedSailingClub];

  void onNameChanged(String data) {
    _store.dispatch(requestUpdateSailingClub(_store.state.sailingClubs[selectedSailingClub].copy(name: data)));
  }

  void onAbbreviationChanged(String data) {
    _store.dispatch(requestUpdateSailingClub(_store.state.sailingClubs[selectedSailingClub].copy(abbreviation: data)));
  }

  void onRegistrationChanged(String data) {
    _store.dispatch(requestUpdateSailingClub(_store.state.sailingClubs[selectedSailingClub].copy(registration: data)));
  }
}
