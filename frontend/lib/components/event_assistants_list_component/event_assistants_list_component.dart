import 'dart:async';
import 'package:angular2/core.dart';

import 'package:frontend/models/person.dart';

typedef Future<Iterable<Person>> GetPersons();

@Component(
    selector: 'my-event-assistants-list',
    templateUrl: 'event_assistants_list_component.html',
    styleUrls: const ['event_assistants_list_component.css'])
class EventAssistantsListComponent implements OnInit {
  @Input()
  List<String> selectedAssistants; // List of Person.urls
  @Input()
  GetPersons getPersons;

  @Output()
  final EventEmitter<String> deleteRequest = new EventEmitter<String>();
  @Output()
  final EventEmitter<String> addRequest = new EventEmitter<String>();

  String selectedObj = ""; // The text in the assistant search field
  Person selectedItemObj; // The selected object from the assistant search

  // List of assistants, calculated from persons filtered by selectedAssistants
  Set<Person> assistants = new Set<Person>();

  Future<Null> getAssistants() async {
    final Iterable<Person> persons = await getPersons();
    assistants.addAll(persons.where((Person person) => selectedAssistants.contains(person.url)));
  }

  @override
  void ngOnInit() {
    getAssistants();
  }

  void addAssistant(Person assistant) {
    print('Selected value: ${assistant.url}');
    addRequest.emit(assistant.url);
    assistants.add(assistant);
  }

  void removeAssistant(Person assistant) {
    deleteRequest.emit(assistant.url);
    assistants.remove(assistant);
  }
}
