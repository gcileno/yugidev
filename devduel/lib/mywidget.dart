import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'listas.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'data.dart';

//estado das telas

class CardsWidget extends StatelessWidget {
  final dynamic jdados;

  CardsWidget(this.jdados);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
            child: escolha2(typeopc, arquetipo),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: gerarCard(jdados),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//
//
//criando meu data service
final dataService = DataService();

//
//
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

//
//funções gerais
//criadas para servir a função cardwidget
//processando e criando widgetes especidifos para a necessidae da aplicação

ListView gerarCard(dynamic jsonData) {
  var jcards = jsonData;

  var cardWidgets = jcards.map<Widget>((xcard) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Color.fromARGB(255, 192, 192, 192),
              width: 2,
            )),
        height: 330,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              child: Image.network(
                xcard['card_images'][0]['image_url_small'],
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(
                        6), // Ajuste o espaçamento interno da borda aqui
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.indigo,
                          width:
                              1, // Ajuste a largura da borda conforme necessário
                        ),
                        borderRadius: BorderRadius.circular(
                            8), // Ajuste o raio do border conforme necessário
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(
                            0.9), // Ajuste o espaçamento interno do conteúdo aqui
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: SizedBox(
                                height: 24,
                                child: Text(
                                  xcard["name"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                height: 22,
                                child: Text(
                                  "Tipo: " + xcard["frameType"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: descricao(xcard["desc"]),
                  ),
                  Row(
                    children: [
                      Center(
                        child: ShowImage(
                          imageUrl: xcard["card_images"][0]["image_url"],
                          nome: xcard["name"],
                          textButon: "Mostrar Carta",
                        ),
                      ),
                      Center(
                        child: ShowImage(
                          imageUrl: xcard["card_images"][0]
                              ["image_url_cropped"],
                          nome: xcard["name"],
                          textButon: "Ver Monstro",
                        ),
                      ),
                      Center(
                          child: IconButton(
                        icon: Icon(
                          Icons.favorite,
                        ),
                        onPressed: () {
                          favoritos.add(xcard["card_images"][0]["image_url"]);
                          print(favoritos);
                        },
                        color: Colors.red,
                      )),
                      Center(child: Icon(Icons.share))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }).toList();

  return ListView.builder(
    itemCount: cardWidgets.length,
    itemBuilder: (context, index) {
      return ListTile(
        title: cardWidgets[index],
      );
    },
  );
}

//container estilizado
Widget descricao(String text) {
  return Padding(
    padding: EdgeInsets.all(8),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 88, 111, 243),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
        ),
      ),
    ),
  );
}

//botão para mostrar imagem
class ShowImage extends StatelessWidget {
  final String imageUrl;
  final String nome;
  final String textButon;

  ShowImage({
    required this.imageUrl,
    required this.nome,
    required this.textButon,
  });

  void mostrarImagem(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(nome),
          content: Image.network(imageUrl),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Fechar',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9.0),
      child: ElevatedButton(
        onPressed: () {
          mostrarImagem(context);
        },
        style: ElevatedButton.styleFrom(
          primary: Color.fromARGB(255, 45, 146, 150),
          padding: EdgeInsets.all(7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          textButon,
          style: TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

//função melhorada para as oções de escolha do usuario e retirado da função principal
Widget escolha2(List<String> typeopc, List<Map<String, dynamic>> arquetipo) {
  var parametro = {'': ''};
  List<Map<String, dynamic>> filteredArquetipo = List.from(arquetipo);

  return Container(
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
          onChanged: (value) {
            parametro = {'type': value.toString()};
            dataService.loadCards(parametro);
          },
          items: typeopc.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TypeAheadField<String>(
            textFieldConfiguration: TextFieldConfiguration(
              onChanged: (text) {
                String filter = text.toLowerCase();
                filteredArquetipo = arquetipo
                    .where((item) => item['archetype_name']
                        .toString()
                        .toLowerCase()
                        .contains(filter))
                    .toList();
                parametro = {'archetype': text};
                dataService.loadCards(parametro);
              },
              decoration: InputDecoration(
                hintText:
                    'Ou digite e selecione o arquetipo de card que deseja:',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            suggestionsCallback: (pattern) async {
              return arquetipo
                  .where((item) => item['archetype_name']
                      .toString()
                      .toLowerCase()
                      .contains(pattern.toLowerCase()))
                  .map((item) => item['archetype_name'].toString())
                  .toList();
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(suggestion),
              );
            },
            onSuggestionSelected: (suggestion) {
              parametro = {'archetype': suggestion.toString()};
              dataService.loadCards(parametro);
            },
          ),
        ),
      ],
    ),
  );
}

Widget imageCarousel(List<String> imageUrls) {
  return Container(
    height: 200,
    child: PageView.builder(
      itemCount: imageUrls.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(imageUrls[index]),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    ),
  );
}
