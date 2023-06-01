import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'listas.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'cards.dart';

//mostrar tabelas
//var imageUrlSmall = jsonData['card_images'][0]['image_url_small'];

Widget mostrarWidgets(List<Widget> widgets) {
  return ListView.builder(
    itemCount: widgets.length,
    itemBuilder: (context, index) {
      return widgets[index];
    },
  );
}

Container descricao(String text) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.indigo[50],
      borderRadius: BorderRadius.circular(8),
    ),
    padding: EdgeInsets.all(8),
    child: Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
    ),
  );
}

class ShowImage extends StatelessWidget {
  final String imageUrl;
  final String nome;
  final String textButon;

  ShowImage(
      {required this.imageUrl, required this.nome, required this.textButon});

  void mostrarImagem(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(nome),
          content: Image.network(imageUrl),
          actions: [
            TextButton(
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        mostrarImagem(context);
      },
      child: Text(textButon),
    );
  }
}

class Telas {
  final ValueNotifier<List> tableStateNotifier = new ValueNotifier([]);

  void carregar(index) {
    final carregadores = [
      () => duelo(),
      () => loadCards(),
      () => creditos(),
    ];
    carregadores[index]();
  }

  void duelo() {
    List<Widget> duelo = [];

    // Adicionando widgets aleatórios à lista duelo
    duelo.add(Text("Widget 1"));
    duelo.add(Container(
      color: Colors.blue,
      height: 50,
      width: 50,
      child: Text("Caixa azul"),
    ));
    duelo.add(Image.network(
        "https://www.konami.com/games/s/inquiry/img/logo_konami.png"));
    duelo.add(ElevatedButton(
      onPressed: () {
        // Ação ao pressionar o botão
      },
      child: Text("Clique aqui"),
    ));

    tableStateNotifier.value = duelo;
  }

  void creditos() {
    List<Widget> cred = [];
    cred.add(Center(
      child: Column(children: [
        Row(
          children: [
            ElevatedButton(onPressed: () {}, child: Text("Botão")),
            Text("Descrição")
          ],
        ),
        Row(
          children: [
            Image.network(
                "https://static.wikia.nocookie.net/yugioh/images/c/c0/ExodiatheForbiddenOne-TF04-JP-VG.jpg/revision/latest?cb=20161003202322&path-prefix=pt"),
            Text("Exodia"),
            TextButton(onPressed: () {}, child: Text("Curtir"))
          ],
        )
      ]),
    ));
    tableStateNotifier.value = cred;
  }

  Future<void> loadCards() async {
    List<Widget> cartoes = [];

    var api_cartas = Uri(
        scheme: 'https',
        host: 'db.ygoprodeck.com',
        path: 'api/v7/cardinfo.php',
        queryParameters: {'language': 'pt', 'type': 'XYZ Monster'});

    var dados = await http.read(api_cartas);

    var jcards = jsonDecode(dados)["data"];

    cartoes = jcards.map<Widget>((xcard) {
      return Card(
        child: Container(
          height: 250,
          width: 100,
          child: Row(
            children: [
              Container(
                child: Image.network(xcard['card_images'][0]['image_url_small'],
                    fit: BoxFit.cover),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text("Nome: " + xcard["name"],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ))),
                        Expanded(
                            child: Text("Tipo: " + xcard["frameType"],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ))),
                      ],
                    ),
                    Expanded(
                      child: descricao(xcard["desc"]),
                    ),
                    Row(children: [
                      Expanded(
                        child: ShowImage(
                          imageUrl: xcard["card_images"][0]["image_url"],
                          nome: xcard["name"],
                          textButon: "Mostrar Carta",
                        ),
                      ), //mostrar carta completa
                      Expanded(
                        child: ShowImage(
                            imageUrl: xcard["card_images"][0]
                                ["image_url_cropped"],
                            nome: xcard["name"],
                            textButon: "Ver Monstro"),
                      )
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();

    tableStateNotifier.value = cartoes;
  }
}

//barra inferior
class Nav extends HookWidget {
  List<Icon> meuincone;

  var itemSelectedCallback;
  Nav({this.meuincone = const [], this.itemSelectedCallback}) {
    itemSelectedCallback ??= (_) {};
  }

  @override
  Widget build(BuildContext context) {
    var state = useState(1);

    return BottomNavigationBar(
        onTap: (index) {
          state.value = index;
          itemSelectedCallback(index);
        },
        currentIndex: state.value,
        items: meuincone
            .map(
              (obj) => BottomNavigationBarItem(label: "", icon: obj),
            )
            .toList());
  }
}
