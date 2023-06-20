import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'listas.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
                  child: gerarCard(jdados, context),
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
    var state = useState(0);

    return BottomNavigationBar(
        onTap: (index) {
          state.value = index;
          itemSelectedCallback(index);
        },
        currentIndex: state.value,
        type: BottomNavigationBarType.fixed,
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

ListView gerarCard(dynamic jsonData, context) {
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
                          MeusFavoritos.add(
                              xcard["card_images"][0]["image_url"]);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Adcionado ao '),
                              duration: Duration(seconds: 2),
                            ),
                          );
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
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.blue),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Escolha o tipo de monstro:"),
        SizedBox(width: double.minPositive),
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

//
//
////mostrar imagens em carrosel
Widget imageCarousel(List<String> imageUrls) {
  return CarouselSlider(
    options: CarouselOptions(
      height: double.maxFinite,
      viewportFraction: 0.8,
      initialPage: 0,
      enableInfiniteScroll: true,
      enlargeCenterPage:
          false, // Evita o zoom na imagem central // Exibe a imagem completa sem cortes
    ),
    items: imageUrls.map((imageUrl) {
      return Container(
        child: Center(
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      );
    }).toList(),
  );
}

//
//
//Tela de boas vindas
Widget welcome() {
  return Container(
    width: 300,
    height: 400,
    decoration: BoxDecoration(
        color: Color.fromARGB(255, 195, 223, 247),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color.fromARGB(179, 14, 0, 75))),
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bem-vindo!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 18, 98, 163),
          ),
        ),
        Text('Clique em:'),
        SizedBox(height: 20),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(Icons.close_sharp, color: Colors.blue),
                  SizedBox(width: 10),
                  Text(
                    'Para a tela de Duelo',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.manage_search, color: Colors.green),
                  SizedBox(width: 10),
                  Text(
                    'Para pesquisar cartas',
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.favorite_border_sharp, color: Colors.red),
                  SizedBox(width: 10),
                  Text(
                    'Para ver suas cartas',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.orange),
                  SizedBox(width: 10),
                  Text(
                    'Para informações do app',
                    style: TextStyle(color: Colors.orange),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
