import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_components/angular_components.dart';

import 'package:frontend/store/regatta_store.dart';
import 'package:frontend/models/boat.dart';
import 'package:frontend/routes.dart';

@Component(
    selector: 'my-boat-detail',
    templateUrl: 'boat_detail_component.html',
    styleUrls: const ['boat_detail_component.css'],
    directives: const [coreDirectives, MaterialTabPanelComponent, MaterialTabComponent, materialInputDirectives],
    providers: const [materialProviders])
class BoatDetailComponent implements OnActivate {
  BoatDetailComponent(this._store);

  String selectedBoat;

  final RegattaStore _store;

  @override
  void onActivate(_, RouterState current) async {
    selectedBoat = current.parameters[keyParam];
  }

  Boat get boat => _store.state.boats[selectedBoat];

  String get yardstick => _store.state.boats[selectedBoat].yardstick.toString();

  void onNameChanged(String data) {
    _store.dispatch(_store.action.requestUpdateBoat(_store.state.boats[selectedBoat].copy(name: data)));
  }

  void onYardstickChanged(String data) {
    _store.dispatch(_store.action.requestUpdateBoat(_store.state.boats[selectedBoat].copy(yardstick: int.parse(data))));
  }
}
