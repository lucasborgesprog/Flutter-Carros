import 'package:carros_custom/pages/carros/carro.dart';
import 'package:carros_custom/pages/carros/carros_api.dart';
import 'package:carros_custom/pages/carros/simple_bloc.dart';
import 'package:carros_custom/pages/carros/carro_dao.dart';
import 'package:carros_custom/pages/favoritos/favorito_service.dart';
import 'package:carros_custom/utils/network.dart';

class FavoritosBloc extends SimpleBloc<List<Carro>> {
  Future<List<Carro>> fetch() async {
    try {
      List<Carro> carros = await FavoritoService.getCarros();

      if (carros.isNotEmpty) {
        final dao = CarroDAO();

        carros.forEach(dao.save);
      }

      add(carros);

      return carros;
    } catch (e) {
      print(e);
      addError(e);
    }
  }
}
