import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:frontend/app_component.dart';
import 'package:frontend/app_component.template.dart' as ng;

import 'main.template.dart' as self;

const bool useHashLS = false;
@GenerateInjector(routerProvidersHash)
final InjectorFactory injectorFactory = self.injectorFactory$Injector;

void main() {
  final ComponentRef ref = runApp(ng.AppComponentNgFactory, createInjector: injectorFactory);
  AppComponent.myinjector = ref.injector;
}
