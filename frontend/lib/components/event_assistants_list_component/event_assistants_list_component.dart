import 'dart:async';
import 'package:angular/angular.dart';

import 'package:frontend/models/person.dart';

typedef Future<Iterable<Person>> GetPersons();

@Component(
  selector: 'my-event-assistants-list',
  templateUrl: 'event_assistants_list_component.html',
  styleUrls: const ['event_assistants_list_component.css'],
  directives: const [coreDirectives]
)
class EventAssistantsListComponent implements OnInit {
  @Input()
  List<String> selectedAssistants; // List of Person.urls
  @Input()
  GetPersons getPersons;

  final _deleteRequest = new StreamController<String>();
  @Output()
  Stream<String> get deleteRequest => _deleteRequest.stream;

  final _addRequest = new StreamController<String>();
  @Output()
  Stream<String> get addRequest => _addRequest.stream;

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
    _addRequest.add(assistant.url);
    assistants.add(assistant);
  }

  void removeAssistant(Person assistant) {
    _deleteRequest.add(assistant.url);
    assistants.remove(assistant);
  }
}
