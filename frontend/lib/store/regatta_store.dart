import 'dart:async';
import 'package:logging/logging.dart';
import 'package:angular2/core.dart';
import 'package:greencat/greencat.dart';
import 'package:frontend/services/event_service.dart';
import 'regatta_action.dart';
import 'regatta_state.dart';
import 'regatta_reducer.dart';

/// Middleware to handle async actions.
class LoggingMiddleware2<S, A extends Action> implements Function {
  final Logger _logger;
  final Level _level;

  /// Default constructor.
  LoggingMiddleware2(Logger logger, Level level)
      : _logger = logger,
        _level = level;

  /// Logs the action, current state and state after applying the reducer.
  DispatchTransformer<A> call(MiddlewareApi<S, A> api) => (next) => (action) {
        _logger.log(_level, 'action: $action');
        _logger.log(_level, 'prev state: ${api.state}');
        final next2 = next(action);
        _logger.log(_level, 'next state: ${api.state}');
        _logger.log(_level, '=== === === === === === === === === === === === === === ');
        return next2;
      };
}

@Injectable()
class RegattaStore extends Store<RegattaState, RegattaAction> {
  final EventService _eventService;

  RegattaStore(this._eventService) : super.createStore(regattaApp) {
    Logger.root.level = Level.INFO;
    Logger.root.onRecord.listen((LogRecord rec) {
      print('${rec.loggerName} ${rec.time}');
      print('${rec.message}');
    });

    // The ThunkMiddleware adds async call capability to actions
    addMiddleware(new ThunkMiddleware<RegattaState, RegattaAction<dynamic>>());
    addMiddleware(new LoggingMiddleware2(Logger.root, Level.INFO));
    loadEvents();
  }

  // FIXME: move this into a separate action
  Future<Null> loadEvents() async {
    print('loadevents start');
    final events = await _eventService.getEvents();
    for (var event in events) {
      dispatch(addEvent(event));
    }
    print('loadevents end');
  }
}
