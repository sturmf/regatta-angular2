import 'dart:async';
import 'package:angular2/router.dart';
import 'package:mockito/mockito_no_mirrors.dart';
import 'package:pageloader/objects.dart';
import 'package:frontend/store/regatta_state.dart';
import 'package:frontend/store/regatta_store.dart';
import 'package:greencat/greencat.dart';

class MockRouter extends Mock implements Router {}

class MockRegattaStore extends Mock implements RegattaStore {}

class MockStore extends Mock implements Store {}

class MockRegattaState extends Mock implements RegattaState {}

@EnsureTag('my-event-list')
class EventListPO {
  @ByCss('.event-item')
  Lazy<List<PageLoaderElement>> _items;

  /// Items in the list.
  Future<List<PageLoaderElement>> get items => _items();
}
