import 'package:carros_custom/pages/carros/carro.dart';
import 'package:carros_custom/pages/carros/carros_listView.dart';
import 'package:carros_custom/pages/favoritos/favoritos_bloc.dart';
import 'package:carros_custom/widgets/text_error.dart';
import 'package:flutter/material.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {
  @override
  bool get wantKeepAlive => true;
  final _bloc = FavoritosBloc();

  @override
  void initState() {
    super.initState();

    _bloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: _bloc.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return TextError(
            msg: "Não foi possível buscar os Favoritos",
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Carro> carros = snapshot.data;

        return RefreshIndicator(
          child: CarrosListView(carros),
          onRefresh: _onRefresh,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.dispose();
  }

  Future<void> _onRefresh() {
    return _bloc.fetch();
  }
}
