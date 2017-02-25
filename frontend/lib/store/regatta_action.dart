import 'dart:async';
import 'action_type.dart';
import 'package:angular2/core.dart';
import 'package:greencat/greencat.dart';
import 'package:frontend/app_component.dart';
import 'package:frontend/models/event.dart';
import 'package:frontend/services/event_service.dart';

/// Utility function to trigger the addEvent action.
RegattaAction<String> requestCreateEvent(String name) => new RequestCreateEventAction(name);

/// Utility function to trigger the addEvent action.
RegattaAction<Event> addEvent(Event event) => new AddEventAction(event);

/// Utility function to request the updateEvent action.
RegattaAction<Event> requestUpdateEvent(Event event) => new RequestUpdateEventAction(event);

/// Utility function to trigger the updateEvent action.
RegattaAction<Event> updateEvent(Event event) => new UpdateEventAction(event);

/// Utility function to request the deleteEvent action.
RegattaAction<Event> requestDeleteEvent(Event event) => new RequestDeleteEventAction(event);

/// Utility function to trigger the deleteEvent action.
RegattaAction<Event> deleteEvent(Event event) => new DeleteEventAction(event);

/// Actions to be triggered to the app store.
abstract class RegattaAction<T> extends Action<ActionType> {
  /// The payload to include.
  @override
  final T payload;

  /// Creates a new instance.
  RegattaAction(this.payload);
}

/// Action to request the add of a new Event.
class RequestCreateEventAction extends RegattaAction<String> implements AsyncAction<ActionType> {
  final EventService _eventService;

  RequestCreateEventAction(String payload)
      : _eventService = AppComponent.myinjector.get(EventService),
        super(payload);

  @override
  ActionType get type => ActionType.requestCreateEvent;

  @override
  Future call(MiddlewareApi api) {
    return _eventService.addEvent(payload).then((event) {
      api.dispatch(addEvent(event));
    });
  }
}

/// Action to add an Event.
class AddEventAction extends RegattaAction<Event> {
  ///
  AddEventAction(Event payload) : super(payload);

  @override
  ActionType get type => ActionType.addEvent;
}

/// Action to add an Event.
class RequestUpdateEventAction extends RegattaAction<Event> implements AsyncAction<ActionType> {
  final EventService _eventService;

  RequestUpdateEventAction(Event payload)
      : _eventService = AppComponent.myinjector.get(EventService),
        super(payload);

  @override
  ActionType get type => ActionType.requestUpdateEvent;

  @override
  Future call(MiddlewareApi api) {
    return _eventService.updateEvent(payload).then((_) {
      api.dispatch(updateEvent(payload));
    });
  }
}

class UpdateEventAction extends RegattaAction<Event> {
  ///
  UpdateEventAction(Event payload) : super(payload);

  @override
  ActionType get type => ActionType.updateEvent;
}

/// Action to add an Event.
class RequestDeleteEventAction extends RegattaAction<Event> implements AsyncAction<ActionType> {
  final EventService _eventService;

  RequestDeleteEventAction(Event payload)
      : _eventService = AppComponent.myinjector.get(EventService),
        super(payload);

  @override
  ActionType get type => ActionType.requestDeleteEvent;

  @override
  Future call(MiddlewareApi api) {
    return _eventService.deleteEvent(payload).then((_) {
      api.dispatch(deleteEvent(payload));
    });
  }
}

/// Action to add an Event.
class DeleteEventAction extends RegattaAction<Event> {
  ///
  DeleteEventAction(Event payload) : super(payload);

  @override
  ActionType get type => ActionType.deleteEvent;
}
