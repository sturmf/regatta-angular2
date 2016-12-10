import 'dart:async';
import 'regatta_action.dart';
import 'regatta_state.dart';
import 'regatta_reducer.dart';
import 'package:angular2/core.dart';
import 'package:greencat/greencat.dart';
import 'package:frontend/services/event_service.dart';

@Injectable()
class RegattaStore {
  final EventService _eventService;
  var store;

  RegattaStore(this._eventService) {
    store = new Store.createStore(regattaApp);
    // The ThunkMiddleware adds async call capability to actions
    store.addMiddleware(new ThunkMiddleware<RegattaState, RegattaAction<dynamic>>());
    loadEvents();
  }

  Future<Null> loadEvents() async {
    print('loadevents start');
    final events = await _eventService.getEvents();
    for (var event in events) {
      print('dispatch');
      store.dispatch(addEvent(event));
      print(store.state);
    }
    print('loadevents end');
  }
}
