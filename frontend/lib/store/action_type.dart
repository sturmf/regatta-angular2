/// The type of actions on the TodoApp.
enum ActionType {
  /// Indicates the intention to create a new event by title
  requestCreateEvent,

  /// Indicates to select a loaded event in the store
  selectEvent,

  /// Indicates to add an event to the store
  addEvent,

  /// Indicates an event changed its data and requires a store update
  updateEvent,

  /// Indicates the intention to delete an event from the store
  requestDeleteEvent,

  /// Indicates to delete an event from the store
  deleteEvent
}
