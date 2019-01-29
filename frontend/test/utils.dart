import 'package:angular/angular.dart';

class InjectorProbe {
  InjectorProbe(this._parent);

  InjectorFactory _parent;
  Injector _injector;

  InjectorFactory get factory => _factory;
  Injector get injector => _injector ??= _factory();

  Injector _factory([Injector parent]) => _injector = _parent(parent);
  T get<T>(dynamic token) => injector?.get(token);
}

