/// The type of actions on the TodoApp.
enum ActionType {
  /// Indicates the intention to create a new event by title
  createNewEvent,

  /// Indicates to add a loaded event to the store
  addEvent,

  /// Indicates the intention to delete an event from the store
  requestDeleteEvent,

  /// Indicates to delete an event from the store
  deleteEvent
}
