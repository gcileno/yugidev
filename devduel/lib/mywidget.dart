import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'listas.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'cards.dart';

//mostrar tabelas
//var imageUrlSmall = jsonData['card_images'][0]['image_url_small'];

class Filtro extends HookWidget {
  Filtro();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(),
    );
  }
}

//estado das telas
class Estado extends StatefulWidget {
  @override
  Telas createState() => Telas();
}

Widget mostrarWidgets(List<Widget> widgets) {
  return Container(
    padding: EdgeInsets.all(16.0),
    child: ListView.builder(
      itemCount: widgets.length,
      itemBuilder: (context, index) {
        return widgets[index];
      },
    ),
  );
}

//container estilizado
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

//botão para mostrar imagem
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
    return TextButton(
      onPressed: () {
        mostrarImagem(context);
      },
      child: Text(textButon),
    );
  }
}

//função principal para chamadas de telas
class Telas extends State<Estado> {
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

    String paramentro = 'Spell Card';

    void atualizarParametro(String novoParametro) {
      setState(() {
        paramentro = novoParametro;
      });
    }

    Widget escolha(List<String> opc) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Escolha o tipo de monstro:"),
            SizedBox(width: 10),
            DropdownButton<String>(
              value: paramentro,
              onChanged: (String? esc) {
                if (esc != null) {
                  atualizarParametro(esc);
                }
              },
              items: opc.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      );
    }

    var api_cartas = Uri(
        scheme: 'https',
        host: 'db.ygoprodeck.com',
        path: 'api/v7/cardinfo.php',
        queryParameters: {'language': 'pt', 'type': paramentro});

    var dados = await http.read(api_cartas);

    var jcards = jsonDecode(dados)["data"];

    cartoes.add(escolha(typeopc));

    //criando cards com as informaçoes da api
    cartoes.addAll(jcards.map<Widget>((xcard) {
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
                      ) //mostrar arte do mosntro
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }).toList());

    tableStateNotifier.value = cartoes;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
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
