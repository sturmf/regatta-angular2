import 'package:angular2/core.dart';
import 'package:angular2/platform/common.dart';
import 'package:angular2/router.dart';

import 'regatta_service.dart';


@Component(
  selector: 'my-app',
  template: '''
    <h1>My First Angular 2 App</h1>
    <div *ngFor="let regatta of regattas">
      <div>
        <h4>{{regatta.name}}</h4>
      </div>
    </div>
    ''',
  directives: const [
    ROUTER_DIRECTIVES
  ],
  providers: const [
    ROUTER_PROVIDERS,
    const Provider(LocationStrategy, useClass: HashLocationStrategy),
    RegattaService
  ]
)


class AppComponent implements OnInit {
  final RegattaService _regattaService;
  List<Regatta> regattas;

  AppComponent(this._regattaService);

  ngOnInit() async => regattas  = (await _regattaService.getRegattas());

}

