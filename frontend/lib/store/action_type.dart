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
  deleteEvent,

  /// Indicates the intention to create a new sailingclub by title
  requestCreateSailingClub,

  /// Indicates to add a sailingclub to the store
  addSailingClub,

  /// Indicates the intention to update a sailingclub in the store
  requestUpdateSailingClub,

  /// Indicates an update a sailingclub in the store
  updateSailingClub,

  /// Indicates the intention to delete a sailingclub from the store
  requestDeleteSailingClub,

  /// Indicates to delete a sailingclub from the store
  deleteSailingClub,

  /// Indicates the intention to create a new sailingclub by title
  requestCreateBoat,

  /// Indicates to add a sailingclub to the store
  addBoat,

  /// Indicates the intention to update a sailingclub in the store
  requestUpdateBoat,

  /// Indicates an update a sailingclub in the store
  updateBoat,

  /// Indicates the intention to delete a sailingclub from the store
  requestDeleteBoat,

  /// Indicates to delete a sailingclub from the store
  deleteBoat
}
