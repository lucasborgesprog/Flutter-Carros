import 'package:carros_custom/pages/carros/carro.dart';
import 'package:carros_custom/pages/carros/carros_listView.dart';
import 'package:carros_custom/pages/favoritos/favoritos_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    FavoritosModel model = Provider.of<FavoritosModel>(context, listen: false);
    model.getCarros();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    FavoritosModel model = Provider.of<FavoritosModel>(context);

    List<Carro> carros = model.carros;

    if (carros.isEmpty) {
      return Center(
        child: Text(
          "Nenhum carro nos favoritos",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return RefreshIndicator(
      child: CarrosListView(carros),
      onRefresh: _onRefresh,
    );

    // return StreamBuilder(
    //   stream: favoritosBloc.stream,
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     if (snapshot.hasError) {
    //       print(snapshot.error);
    //       return TextError(
    //         msg: "Não foi possível buscar os Favoritos",
    //       );
    //     }

    //     if (!snapshot.hasData) {
    //       return Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     }

    //     List<Carro> carros = snapshot.data;

    //   },
    // );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _onRefresh() {
    return Provider.of<FavoritosModel>(context, listen: false).getCarros();
  }
}
