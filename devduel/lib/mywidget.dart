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
    duelo.add(Container(
      color: Colors.blue,
      height: 50,
      width: 50,
      child: Text(
          "Use suas cartar em modo defesa ou ataque e reduza\n os pontos do vida do oponente a zero"),
    ));
    duelo.add(Image.network(
        "https://www.konami.com/games/s/inquiry/img/logo_konami.png"));
    duelo.add(ElevatedButton(
      onPressed: () {
        // Ação ao pressionar o botão
      },
      child: Text("Inicie o jogo"),
    ));

    tableStateNotifier.value = duelo;
  }

  void creditos() {
    List<Widget> creditos = [
      Column(
        children: [
          Row(
            children: [
              Container(
                width: 150,
                height: 150,
                color: Color.fromARGB(255, 138, 0, 0),
                child: Center(
                  child: Image.network(
                    'https://pbs.twimg.com/profile_images/3190248843/9d85cb3312179987e6f25febd52e5fa2_200x200.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Konami Holdings Corporation (株式会社コナミホールディングス Kabushiki-gaisha Konami Hōrudingusu?) é uma empresa pública japonesa desenvolvedora e distribuidora de jogos eletrônicos, brinquedos, animes, cromos, tokusatsus e máquinas de caça-níqueis. A empresa foi fundada em 1969 como uma empresa de aluguel e reparação de jukeboxes em Osaka, Japão por Kagemasa Kozuki, o ainda atual presidente do conselho de administração e CEO. ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: 150,
                height: 150,
                color: Color.fromARGB(255, 138, 0, 0),
                child: Center(
                  child: Image.network(
                    'https://avatars.githubusercontent.com/u/37552458?v=4',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      launch('https://ygoprodeck.com/api-guide/');
                    },
                    child: Text(
                      'Clique aqui para visitar o site da API',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      launch('https://github.com/AlanOC91');
                    },
                    child: Text(
                      'Clique aqui para visitar o github do desenvolvedor da API',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: 150,
                height: 150,
                color: Color.fromARGB(255, 138, 0, 0),
                child: Center(
                  child: Image.network(
                    'https://scontent.fjdo10-1.fna.fbcdn.net/v/t39.30808-6/332926026_8839187282822982_7674830938355777980_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=S2kCg3sjcgUAX8KLsJy&_nc_ht=scontent.fjdo10-1.fna&oh=00_AfD9_H98Kou1oUONYlS-rKSUFMR-Y3tYKST96-79AIedNQ&oe=648A32A6',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Desenvolvedores: Gabriel Cileno e Laian Kevin',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      launch('https://github.com/gcileno/yugidev');
                    },
                    child: Text(
                      'Clique aqui para visitar o github do desenvolvedor',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ];
    tableStateNotifier.value = creditos;
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
