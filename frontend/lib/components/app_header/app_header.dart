import 'package:angular2/angular2.dart';
import 'package:angular2_components/angular2_components.dart';

import 'package:frontend/services/firebase_service.dart';

@Component(
    selector: 'app-header',
    templateUrl: 'app_header.html',
    styleUrls: const ['app_header.css'],
    directives: const [materialDirectives],
    providers: const [materialProviders])
class AppHeader {
  final FirebaseService fbService;

  AppHeader(this.fbService);
}
