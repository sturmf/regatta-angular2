const admin = require('firebase-admin');
const functions = require('firebase-functions');
const algoliasearch = require('algoliasearch');

admin.initializeApp();

const ALGOLIA_ID = functions.config().algolia.app_id;
const ALGOLIA_API_KEY = functions.config().algolia.api_key;
const ALGOLIA_INDEX_NAME = 'events';

const client = algoliasearch(ALGOLIA_ID, ALGOLIA_API_KEY);
const firestore = admin.firestore();

function updateEvent(id, event) {
  // Prepare data to store in index
  const _data = {}
  _data.name = event.name;
  _data.start_date = event.start_date;
  _data.end_date = event.end_date;
  try {
    firestore.doc(`/sailing_clubs/${event.organizer}`).get()
      .then(doc => _data.organizer = doc.get('name'))
      .catch((error) => console.log('could not resolve organizer'));
  }
  catch	(error) {
    console.log('Invalid arguent');
  }
 
  // Add an 'objectID' field which Algolia requires
  _data.objectID = id;

  // Write to the algolia index
  const index = client.initIndex(ALGOLIA_INDEX_NAME);
  return index.saveObject(_data);
}


function deleteEvent(id) {
  // Remove from the algolia index
  const index = client.initIndex(ALGOLIA_INDEX_NAME);
  return index.deleteObject(id);
}


exports.onEventCreated = functions.firestore.document('events/{eventId}').onCreate((snap, context) => {
  return updateEvent(context.params.eventId, snap.data());
});

exports.onEventUpdated = functions.firestore.document('events/{eventId}').onUpdate((snap, context) => {
  return updateEvent(context.params.eventId, snap.after.data());
});

exports.onEventDeleted = functions.firestore.document('events/{eventId}').onDelete((snap, context) => {
  return deleteEvent(context.params.eventId);
});
