import 'package:carros_custom/pages/carros/carro.dart';
import 'package:carros_custom/pages/carros/carros_api.dart';
import 'package:carros_custom/pages/carros/simple_bloc.dart';
import 'package:carros_custom/pages/carros/carro_dao.dart';
import 'package:carros_custom/utils/network.dart';

class CarrosBloc extends SimpleBloc<List<Carro>> {
  Future<List<Carro>> fetch(String tipo) async {
    try {
      if (!await isNetworkOn()) {
        List<Carro> carros = await CarroDAO().findAllByTipo(tipo);
        add(carros);
        return carros;
      }

      List<Carro> carros = await CarrosApi.getCarros(tipo);

      if (carros.isNotEmpty) {
        final dao = CarroDAO();

        carros.forEach(dao.save);
      }

      add(carros);

      return carros;
    } catch (e) {
      print(e);
      addError(e);

      return [];
    }
  }
}
