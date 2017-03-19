import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:frontend/store/regatta_store.dart';
import 'package:frontend/store/regatta_action.dart';

import 'package:frontend/models/sailing_club.dart';

@Component(
    selector: 'my-sailing-club-list',
    templateUrl: 'sailing_club_list_component.html',
    styleUrls: const ['sailing_club_list_component.css'],
    directives: const [materialDirectives],
    //changeDetection: ChangeDetectionStrategy.OnPush,
    providers: const [materialProviders])
class SailingClubListComponent {
  final Router _router;
  final RegattaStore _store;

  SailingClubListComponent(this._router, this._store);

  String sailingClubName = '';
  Iterable<SailingClub> get sailingClubs => _store.state.sailingClubs.values;

  void addNewSailingClubHandler() {
    if (sailingClubName.length > 0) {
      _store.dispatch(requestCreateSailingClub(sailingClubName));
      sailingClubName = '';
    }
  }

  void deleteSailingClubHandler(SailingClub sailingClub) {
    _store.dispatch(requestDeleteSailingClub(sailingClub));
  }

  void gotoSailingClub(SailingClub sailingClub) {
    final List<dynamic> link = [
      'SailingClubDetail',
      {'key': sailingClub.key}
    ];
    _router.navigate(link);
  }
}
