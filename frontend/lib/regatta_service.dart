import 'package:angular2/core.dart';

import 'regatta.dart';

final List<Regatta> mockRegattas = [
    new Regatta(1, 'Bayerische Jugendwoche'),
    new Regatta(2, 'Lasercup'),
];

@Injectable()
class RegattaService {
  List<Regatta> getRegattas() => mockRegattas;
}
