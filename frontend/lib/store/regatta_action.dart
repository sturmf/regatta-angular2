import 'dart:async';
import 'action_type.dart';
import 'package:angular2/core.dart';
import 'package:greencat/greencat.dart';
import 'package:frontend/app_component.dart';
import 'package:frontend/models/event.dart';
import 'package:frontend/services/event_service.dart';

/// Utility function to trigger the addEvent action.
RegattaAction<Event> addEvent(Event event) => new AddEventAction(event);

/// Utility function to trigger the addEvent action.
RegattaAction<String> addNewEvent(String name) => new AddNewEventAction(name);

/// Actions to be triggered to the app store.
abstract class RegattaAction<T> extends Action<ActionType> {
  /// The payload to include.
  @override
  final T payload;

  /// Creates a new instance.
  RegattaAction(this.payload);
}

/// Action to add an Event.
class AddEventAction extends RegattaAction<Event> {
  ///
  AddEventAction(Event payload) : super(payload);

  @override
  ActionType get type => ActionType.addEvent;
}

/// Action to request the add of a new Event.
class AddNewEventAction extends RegattaAction<String> implements AsyncAction<ActionType> {
  final EventService _eventService;

  ///
  AddNewEventAction(String payload)
      : _eventService = AppComponent.myinjector.get(EventService),
        super(payload);

  @override
  ActionType get type => ActionType.createNewEvent;

  @override
  Future call(MiddlewareApi api) {
    return _eventService.addEvent(payload).then((event) {
      api.dispatch(addEvent(event));
    });
  }
}
