import 'package:angular2/core.dart';

import 'models/event.dart';
import 'models/person.dart';


@Component(
  selector: 'my-event-assistants-list',
  templateUrl: 'event_assistants_list_component.html',
  styleUrls: const ['event_assistants_list_component.css']
)
class EventAssistantsListComponent implements OnChanges {
  @Input() Event event;
  @Input() List<Person> persons;

  @Output() final deleteRequest = new EventEmitter<String>();

  List<Person> assistants = new List();

  EventAssistantsListComponent();

  ngOnChanges(changeRecord) {
    // We have to make sure both event and persons are loaded
    if (event != null && persons != null) {
      for (var person in persons) {
        if (event.assistants.any((val) => val == person.url)) {
          assistants.add(person);
        }
      }
    }
  }

  // search
  // addAssistant

  removeAssistant(assistant) {
    // remove from event and from display list
    deleteRequest.emit(assistant.url);
    assistants.remove(assistant); // FIXME: can we get this updated from the main model?
  }
}
