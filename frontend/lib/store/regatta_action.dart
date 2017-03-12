import 'dart:async';
import 'action_type.dart';
import 'package:angular2/core.dart';
import 'package:greencat/greencat.dart';
import 'package:frontend/app_component.dart';
import 'package:frontend/models/event.dart';
import 'package:frontend/services/event_service.dart';
import 'package:frontend/services/firebase_service.dart';

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
  final FirebaseService _fbService;

  RequestCreateEventAction(String payload)
      : _fbService = AppComponent.myinjector.get(FirebaseService),
        super(payload);

  @override
  ActionType get type => ActionType.requestCreateEvent;

  @override
  Future call(MiddlewareApi api) {
    return _fbService.addEvent(new Event(null, payload));
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
  final FirebaseService _fbService;

  RequestUpdateEventAction(Event payload)
      : _fbService = AppComponent.myinjector.get(FirebaseService),
        super(payload);

  @override
  ActionType get type => ActionType.requestUpdateEvent;

  @override
  Future call(MiddlewareApi api) {
    return _fbService.updateEvent(payload);
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
  final FirebaseService _fbService;

  RequestDeleteEventAction(Event payload)
      : _fbService = AppComponent.myinjector.get(FirebaseService),
        super(payload);

  @override
  ActionType get type => ActionType.requestDeleteEvent;

  @override
  Future call(MiddlewareApi api) {
    return _fbService.deleteEvent(payload);
  }
}

/// Action to delete an Event.
class DeleteEventAction extends RegattaAction<Event> {
  ///
  DeleteEventAction(Event payload) : super(payload);

  @override
  ActionType get type => ActionType.deleteEvent;
}
