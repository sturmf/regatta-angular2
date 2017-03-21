import 'dart:async';
import 'action_type.dart';
import 'package:greencat/greencat.dart';
import 'package:frontend/app_component.dart';
import 'package:frontend/models/event.dart';
import 'package:frontend/models/sailing_club.dart';
import 'package:frontend/models/boat.dart';
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

/// Utility function to trigger the addSailingClub action.
RegattaAction<String> requestCreateSailingClub(String name) => new RequestCreateSailingClubAction(name);

/// Utility function to trigger the addSailingClub action.
RegattaAction<SailingClub> addSailingClub(SailingClub sailingClub) => new AddSailingClubAction(sailingClub);

/// Utility function to request the updateSailingClub action.
RegattaAction<SailingClub> requestUpdateSailingClub(SailingClub sailingClub) =>
    new RequestUpdateSailingClubAction(sailingClub);

/// Utility function to trigger the updateSailingClub action.
RegattaAction<SailingClub> updateSailingClub(SailingClub sailingClub) => new UpdateSailingClubAction(sailingClub);

/// Utility function to request the deleteSailingClub action.
RegattaAction<SailingClub> requestDeleteSailingClub(SailingClub sailingClub) =>
    new RequestDeleteSailingClubAction(sailingClub);

/// Utility function to trigger the deleteSailingClub action.
RegattaAction<SailingClub> deleteSailingClub(SailingClub sailingClub) => new DeleteSailingClubAction(sailingClub);

/// Utility function to trigger the addBoat action.
RegattaAction<String> requestCreateBoat(String name) => new RequestCreateBoatAction(name);

/// Utility function to trigger the addBoat action.
RegattaAction<Boat> addBoat(Boat sailingClub) => new AddBoatAction(sailingClub);

/// Utility function to request the updateBoat action.
RegattaAction<Boat> requestUpdateBoat(Boat sailingClub) => new RequestUpdateBoatAction(sailingClub);

/// Utility function to trigger the updateBoat action.
RegattaAction<Boat> updateBoat(Boat sailingClub) => new UpdateBoatAction(sailingClub);

/// Utility function to request the deleteBoat action.
RegattaAction<Boat> requestDeleteBoat(Boat sailingClub) => new RequestDeleteBoatAction(sailingClub);

/// Utility function to trigger the deleteBoat action.
RegattaAction<Boat> deleteBoat(Boat sailingClub) => new DeleteBoatAction(sailingClub);

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

/// Action to delete an Event.
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

/// Action to request the add of a new SailingClub.
class RequestCreateSailingClubAction extends RegattaAction<String> implements AsyncAction<ActionType> {
  final FirebaseService _fbService;

  RequestCreateSailingClubAction(String payload)
      : _fbService = AppComponent.myinjector.get(FirebaseService),
        super(payload);

  @override
  ActionType get type => ActionType.requestCreateSailingClub;

  @override
  Future call(MiddlewareApi api) {
    return _fbService.addSailingClub(new SailingClub(null, payload));
  }
}

/// Action to add a SailingClub.
class AddSailingClubAction extends RegattaAction<SailingClub> {
  ///
  AddSailingClubAction(SailingClub payload) : super(payload);

  @override
  ActionType get type => ActionType.addSailingClub;
}

/// Action to add a SailingClub.
class RequestUpdateSailingClubAction extends RegattaAction<SailingClub> implements AsyncAction<ActionType> {
  final FirebaseService _fbService;

  RequestUpdateSailingClubAction(SailingClub payload)
      : _fbService = AppComponent.myinjector.get(FirebaseService),
        super(payload);

  @override
  ActionType get type => ActionType.requestUpdateSailingClub;

  @override
  Future call(MiddlewareApi api) {
    return _fbService.updateSailingClub(payload);
  }
}

class UpdateSailingClubAction extends RegattaAction<SailingClub> {
  ///
  UpdateSailingClubAction(SailingClub payload) : super(payload);

  @override
  ActionType get type => ActionType.updateSailingClub;
}

/// Action to delete a SailingClub.
class RequestDeleteSailingClubAction extends RegattaAction<SailingClub> implements AsyncAction<ActionType> {
  final FirebaseService _fbService;

  RequestDeleteSailingClubAction(SailingClub payload)
      : _fbService = AppComponent.myinjector.get(FirebaseService),
        super(payload);

  @override
  ActionType get type => ActionType.requestDeleteSailingClub;

  @override
  Future call(MiddlewareApi api) {
    return _fbService.deleteSailingClub(payload);
  }
}

/// Action to delete a SailingClub.
class DeleteSailingClubAction extends RegattaAction<SailingClub> {
  ///
  DeleteSailingClubAction(SailingClub payload) : super(payload);

  @override
  ActionType get type => ActionType.deleteSailingClub;
}

/// Action to request the add of a new Boat.
class RequestCreateBoatAction extends RegattaAction<String> implements AsyncAction<ActionType> {
  final FirebaseService _fbService;

  RequestCreateBoatAction(String payload)
      : _fbService = AppComponent.myinjector.get(FirebaseService),
        super(payload);

  @override
  ActionType get type => ActionType.requestCreateBoat;

  @override
  Future call(MiddlewareApi api) {
    return _fbService.addBoat(new Boat(null, payload));
  }
}

/// Action to add a Boat.
class AddBoatAction extends RegattaAction<Boat> {
  ///
  AddBoatAction(Boat payload) : super(payload);

  @override
  ActionType get type => ActionType.addBoat;
}

/// Action to add a Boat.
class RequestUpdateBoatAction extends RegattaAction<Boat> implements AsyncAction<ActionType> {
  final FirebaseService _fbService;

  RequestUpdateBoatAction(Boat payload)
      : _fbService = AppComponent.myinjector.get(FirebaseService),
        super(payload);

  @override
  ActionType get type => ActionType.requestUpdateBoat;

  @override
  Future call(MiddlewareApi api) {
    return _fbService.updateBoat(payload);
  }
}

class UpdateBoatAction extends RegattaAction<Boat> {
  ///
  UpdateBoatAction(Boat payload) : super(payload);

  @override
  ActionType get type => ActionType.updateBoat;
}

/// Action to delete a Boat.
class RequestDeleteBoatAction extends RegattaAction<Boat> implements AsyncAction<ActionType> {
  final FirebaseService _fbService;

  RequestDeleteBoatAction(Boat payload)
      : _fbService = AppComponent.myinjector.get(FirebaseService),
        super(payload);

  @override
  ActionType get type => ActionType.requestDeleteBoat;

  @override
  Future call(MiddlewareApi api) {
    return _fbService.deleteBoat(payload);
  }
}

/// Action to delete a Boat.
class DeleteBoatAction extends RegattaAction<Boat> {
  ///
  DeleteBoatAction(Boat payload) : super(payload);

  @override
  ActionType get type => ActionType.deleteBoat;
}
