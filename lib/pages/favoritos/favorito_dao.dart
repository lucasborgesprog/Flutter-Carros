import 'package:carros_custom/utils/sql/base_dao.dart';
import 'package:carros_custom/pages/favoritos/favorito.dart';

class FavoritoDAO extends BaseDAO<Favorito> {
  @override
  Favorito fromMap(Map<String, dynamic> map) {
    return Favorito.fromMap(map);
  }

  @override
  String get tableName => "favorito";
}
