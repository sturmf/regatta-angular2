import 'package:angular2/core.dart';
import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';

import 'package:frontend/store/regatta_store.dart';
import 'package:frontend/store/regatta_action.dart';
import 'package:frontend/models/boat.dart';

@Component(
    selector: 'my-boat-detail',
    templateUrl: 'boat_detail_component.html',
    styleUrls: const ['boat_detail_component.css'],
    directives: const [materialDirectives],
    providers: const [materialProviders])
class BoatDetailComponent {
  final RegattaStore _store;
  final RouteParams _routeParams;
  String selectedBoat;

  BoatDetailComponent(this._store, this._routeParams) {
    selectedBoat = _routeParams.get('key');
  }

  Boat get boat => _store.state.boats[selectedBoat];

  String get yardstick => _store.state.boats[selectedBoat].yardstick.toString();

  void onNameChanged(String data) {
    _store.dispatch(requestUpdateBoat(_store.state.boats[selectedBoat].copy(name: data)));
  }

  void onYardstickChanged(String data) {
    _store.dispatch(requestUpdateBoat(_store.state.boats[selectedBoat].copy(yardstick: int.parse(data))));
  }
}
