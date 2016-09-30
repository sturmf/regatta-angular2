import 'dart:async';
import 'package:angular2/core.dart';
import 'package:ng_bootstrap/ng_bootstrap.dart';

import 'models/person.dart';


@Component(
  selector: 'my-event-assistants-list',
  templateUrl: 'event_assistants_list_component.html',
  styleUrls: const ['event_assistants_list_component.css'],
  directives: const [BsTypeAheadComponent]
)
class EventAssistantsListComponent implements OnChanges {
  @Input() List<String> selectedAssistants; // List of Person.urls
  @Input() List<Person> persons;

  @Output() final deleteRequest = new EventEmitter<String>();
  @Output() final addRequest = new EventEmitter<String>();

  String selectedObj = ""; // The text in the assistant search field
  Person selectedItemObj; // The selected object from the assistant search

  EventAssistantsListComponent get context => this;

  // List of assistants, calculated from persons filtered by selectedAssistants
  List<Person> assistants = new List();

  //List<Person> persons2 = [new Person(1, 'url', 'f', 'l', 'sc'), new Person(2, 'url', 'd', 'f', 'sc')];

  EventAssistantsListComponent();

  ngOnChanges(changeRecord) {
    // We have to make sure both selectedItems and persons are loaded
    if (selectedAssistants != null && persons != null) {
      assistants.clear();
      for (var person in persons) {
        if (selectedAssistants.any((val) => val == person.url)) {
          assistants.add(person);
        }
      }
    }
  }

  addAssistant(person) {
    print('Selected value: ${person.url}');
    addRequest.emit(person.url);
  }

  removeAssistant(assistant) {
    deleteRequest.emit(assistant.url);
  }
}
