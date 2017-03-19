import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:frontend/store/regatta_store.dart';
import 'package:frontend/store/regatta_action.dart';

import 'package:frontend/models/boat.dart';

@Component(
    selector: 'my-boat-list',
    templateUrl: 'boat_list_component.html',
    styleUrls: const ['boat_list_component.css'],
    directives: const [materialDirectives],
    //changeDetection: ChangeDetectionStrategy.OnPush,
    providers: const [materialProviders])
class BoatListComponent {
  final Router _router;
  final RegattaStore _store;

  BoatListComponent(this._router, this._store);

  String boatName = '';
  Iterable<Boat> get boats => _store.state.boats.values;

  void addNewBoatHandler() {
    if (boatName.length > 0) {
      _store.dispatch(requestCreateBoat(boatName));
      boatName = '';
    }
  }

  void deleteBoatHandler(Boat boat) {
    _store.dispatch(requestDeleteBoat(boat));
  }

  void gotoBoat(Boat boat) {
    final List<dynamic> link = [
      'BoatDetail',
      {'key': boat.key}
    ];
    _router.navigate(link);
  }
}
