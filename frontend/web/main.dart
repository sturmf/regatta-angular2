import 'package:angular/angular.dart';
import 'package:frontend/app_component.dart';

void main() {
  bootstrap(AppComponent).then((ComponentRef ref) => AppComponent.myinjector = ref.injector);
}
