/// The type of actions on the TodoApp.
enum ActionType {
  /// Indicates the intention to create a new event by title
  requestCreateEvent,

  /// Indicates to add an event to the store
  addEvent,

  /// Indicates the intention to update an even in the store
  requestUpdateEvent,

  /// Indicates an update an event in the store
  updateEvent,

  /// Indicates the intention to delete an event from the store
  requestDeleteEvent,

  /// Indicates to delete an event from the store
  deleteEvent
}
