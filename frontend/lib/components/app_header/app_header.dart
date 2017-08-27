import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'package:frontend/services/firebase_service.dart';

@Component(
    selector: 'app-header',
    templateUrl: 'app_header.html',
    styleUrls: const ['app_header.css'],
    directives: const [CORE_DIRECTIVES, materialDirectives],
    providers: const [materialProviders])
class AppHeader {
  final FirebaseService fbService;

  AppHeader(this.fbService);
}
