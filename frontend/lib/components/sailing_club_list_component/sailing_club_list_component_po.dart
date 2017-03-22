import 'dart:async';
import 'package:angular2/router.dart';
import 'package:mockito/mockito.dart';
import 'package:pageloader/objects.dart';
import 'package:frontend/store/regatta_state.dart';
import 'package:frontend/store/regatta_store.dart';

class MockRouter extends Mock implements Router {}

class MockRegattaState extends Mock implements RegattaState {}

class MockRegattaStore extends Mock implements RegattaStore {
  @override
  RegattaState state = new MockRegattaState();
}

@EnsureTag('my-sailing-club-list')
class SailingClubListPO {
  @ByCss('.sailing-club-item')
  Lazy<List<PageLoaderElement>> _items;

  /// Items in the list.
  Future<List<PageLoaderElement>> get items => _items();
}
