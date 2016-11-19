import 'dart:async';
import 'package:angular2/router.dart';
import 'package:mockito/mockito_no_mirrors.dart';
import 'package:pageloader/objects.dart';
import 'package:frontend/services/event_service.dart';

class MockRouter extends Mock implements Router {}
class MockEventService extends Mock implements EventService {}

@EnsureTag('my-event-list')
class EventListPO {

  @ByCss('.list-group-item')
  Lazy<List<PageLoaderElement>> _items;

  /// Items in the list.
  Future<List<PageLoaderElement>> get items => _items();
}