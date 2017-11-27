import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_components/angular_components.dart';
import 'package:frontend/models/person.dart';
import 'package:frontend/store/regatta_store.dart';
import 'package:frontend/store/regatta_action.dart';

import 'package:frontend/models/sailing_club.dart';

@Component(
    selector: 'my-sailing-club-list',
    templateUrl: 'sailing_club_list_component.html',
    styleUrls: const ['sailing_club_list_component.css'],
    directives: const [CORE_DIRECTIVES, materialDirectives],
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
      Person currentUser = new Person(1234, 'my url');
      _store.dispatch(requestCreateSailingClub(sailingClubName, initialAdmin: currentUser)); // FIXME: add id from store _store.currentUser
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
