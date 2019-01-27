import 'package:angular_router/angular_router.dart';
import 'package:mockito/mockito.dart';
import 'package:pageloader/pageloader.dart';
import 'package:frontend/store/regatta_state.dart';
import 'package:frontend/store/regatta_store.dart';
import 'package:frontend/store/regatta_action.dart';

part 'event_list_component_po.g.dart';

class MockRouter extends Mock implements Router {}

class MockRegattaState extends Mock implements RegattaState {}

class MockRegattaStore extends Mock implements RegattaStore {
  @override
  RegattaState state = new MockRegattaState();
}

class MockRegattaActionHelper extends Mock implements RegattaActionHelper {}

@PageObject()
abstract class EventListComponentPO {
  EventListComponentPO();
  factory EventListComponentPO.create(PageLoaderElement context) = $EventListComponentPO.create;

  @ByCss('.event-item')
  List<PageLoaderElement> get items;

  /// Items in the list.
 // List<PageLoaderElement> get items => _items; // FIXME: remove and make public?
}
