import 'dart:async';
import 'regatta_action.dart';
import 'regatta_state.dart';
import 'regatta_reducer.dart';
import 'package:angular2/core.dart';
import 'package:greencat/greencat.dart';
import 'package:frontend/services/event_service.dart';

@Injectable()
class RegattaStore extends Store<RegattaState, RegattaAction> {
  final EventService _eventService;

  RegattaStore(this._eventService) : super.createStore(regattaApp) {
    // The ThunkMiddleware adds async call capability to actions
    addMiddleware(new ThunkMiddleware<RegattaState, RegattaAction<dynamic>>());
    loadEvents();
  }

  Future<Null> loadEvents() async {
    print('loadevents start');
    final events = await _eventService.getEvents();
    for (var event in events) {
      print('dispatch');
      dispatch(addEvent(event));
      print(state);
    }
    print('loadevents end');
  }
}
