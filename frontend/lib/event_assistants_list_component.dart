import 'package:angular2/core.dart';

import 'models/person.dart';


@Component(
  selector: 'my-event-assistants-list',
  templateUrl: 'event_assistants_list_component.html',
  styleUrls: const ['event_assistants_list_component.css']
)
class EventAssistantsListComponent implements OnChanges {
  @Input() List<String> selectedItems;
  @Input() List<Person> persons; // FIXME: replace by generic interface

  @Output() final deleteRequest = new EventEmitter<String>();

  List<Person> assistants = new List();
  List<Person> searchResults = new List();

  EventAssistantsListComponent();

  ngOnChanges(changeRecord) {
    // We have to make sure both selectedItems and persons are loaded
    if (selectedItems != null && persons != null) {
      assistants.clear();
      for (var person in persons) {
        if (selectedItems.any((val) => val == person.url)) {
          assistants.add(person);
        }
      }
    }
  }


  search(String term) {
    searchResults.clear();
    if (term.length > 0) {
      for (var person in persons) {
        if (person.first_name.toUpperCase().contains(term.toUpperCase())) {
          searchResults.add(person);
        }
      }
    }
  }

  // addAssistant

  removeAssistant(assistant) {
    deleteRequest.emit(assistant.url);
  }
}
