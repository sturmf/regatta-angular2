import 'package:angular2/core.dart';
import 'package:ng_bootstrap/ng_bootstrap.dart';

import 'models/person.dart';


@Component(
  selector: 'my-event-assistants-list',
  templateUrl: 'event_assistants_list_component.html',
  styleUrls: const ['event_assistants_list_component.css'],
  directives: const [BsTypeAheadComponent]
)
class EventAssistantsListComponent implements OnInit {
  @Input() List<String> selectedAssistants; // List of Person.urls
  @Input() Function getPersons;

  @Output() final deleteRequest = new EventEmitter<String>();
  @Output() final addRequest = new EventEmitter<String>();

  String selectedObj = ""; // The text in the assistant search field
  Person selectedItemObj; // The selected object from the assistant search

  // List of assistants, calculated from persons filtered by selectedAssistants
  Set<Person> assistants = new Set();

  ngOnInit() async {
    Iterable<Person> persons = await (getPersons());
    for (var person in persons) {
      if (selectedAssistants.any((val) => val == person.url)) {
        assistants.add(person);
      }
    }
  }

  addAssistant(Person assistant) {
    print('Selected value: ${assistant.url}');
    addRequest.emit(assistant.url);
    assistants.add(assistant);
  }

  removeAssistant(Person assistant) {
    deleteRequest.emit(assistant.url);
    assistants.remove(assistant);
  }
}
