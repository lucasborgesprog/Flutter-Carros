import 'dart:async';

import 'package:carros_custom/pages/carros/carro.dart';
import 'package:carros_custom/pages/carros/carros_bloc.dart';
import 'package:carros_custom/pages/carros/carros_listView.dart';
import 'package:carros_custom/utils/event_bus.dart';
import 'package:carros_custom/widgets/text_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarrosPage extends StatefulWidget {
  final String tipo;
  CarrosPage(this.tipo);

  @override
  _CarrosPageState createState() => _CarrosPageState();
}

class _CarrosPageState extends State<CarrosPage>
    with AutomaticKeepAliveClientMixin<CarrosPage> {
  StreamSubscription<Event> subscription;

  @override
  bool get wantKeepAlive => true;

  List<Carro> carros;
  final _bloc = CarrosBloc();
  String get tipo => widget.tipo;

  @override
  void initState() {
    super.initState();

    _bloc.fetch(tipo);

    final bus = EventBus.get(context);
    subscription = bus.stream.listen((Event e) {
      print("Event $e");
      CarroEvent carroEvent = e;
      if (carroEvent.tipo == tipo) {
        _bloc.fetch(tipo);
      }
    });
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
            msg: "Não foi possível buscar os carros",
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
    subscription.cancel();
  }

  Future<void> _onRefresh() {
    return _bloc.fetch(tipo);
  }
}
