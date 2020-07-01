import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros_custom/pages/carros/carro.dart';
import 'package:carros_custom/pages/carros/carro_page.dart';
import 'package:carros_custom/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class CarrosListView extends StatelessWidget {
  final List<Carro> carros;

  CarrosListView(this.carros);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: carros != null ? carros.length : 0,
        itemBuilder: (context, index) {
          Carro c = carros[index];

          return InkWell(
            onTap: () => _onClickCarro(context, c),
            onLongPress: () => _onLongClickCarro(context, c),
            child: Card(
              color: Colors.grey[300],
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: c.urlFoto ??
                            "http://www.livroandroid.com.br/livro/carros/esportivos/Ferrari_FF.png",
                        width: 250,
                      ),
                    ),
                    Text(
                      c.nome,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      c.descricao,
                      style: TextStyle(fontSize: 16),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('DETALHES'),
                          onPressed: () => _onClickCarro(context, c),
                        ),
                        FlatButton(
                          child: const Text('SHARE'),
                          onPressed: () => _onClickShare(context, c),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _onClickCarro(context, Carro c) {
    push(context, CarroPage(c));
  }

  _onClickShare(BuildContext context, Carro c) {
    Share.share(c.urlFoto);
  }

  _onLongClickCarro(BuildContext context, Carro c) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(c.nome,
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ListTile(
                  leading: Icon(Icons.directions_car),
                  title: Text("Detalhes"),
                  onTap: () {
                    pop(context);
                    _onClickCarro(context, c);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.share),
                  title: Text("Share"),
                  onTap: () {
                    pop(context);
                    _onClickShare(context, c);
                  },
                ),
              ],
            ),
          );
        });
  }
}
