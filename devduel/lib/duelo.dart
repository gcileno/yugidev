import 'package:flutter/material.dart';
import 'player.dart';

Widget mesa1(dynamic jsonData) {
  var _cards = jsonData;

  Player jogador = Player('Jogador 1', criarBaralho(jsonData));
  jogador.puxarCarta();

  return Container(
      height: 200,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.all(8),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color.fromARGB(255, 92, 108, 250),
          ),
          padding: EdgeInsets.all(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //carta 01
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Row(
                  children: [
                    Center(
                      child: Image.network(
                        jogador.hand[0].image,
                        width: 90,
                        height: 180,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Ação do botão
                          },
                          child: Text(jogador.hand[0].atk.toString()),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Ação do botão
                          },
                          child: Text(jogador.hand[0].def.toString()),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //Carta 02
              Container(
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Row(
                  children: [
                    Center(
                      child: Image.network(
                        'https://i.pinimg.com/564x/2e/fe/0d/2efe0d53dd2799777a951e26af018381.jpg',
                        width: 90,
                        height: 180,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Ação do botão
                          },
                          child: Text('Ataque'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Ação do botão
                          },
                          child: Text('Defesa'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )));
}

Widget mesaPc() {
  return Container(
      height: 190,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.all(6),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color.fromARGB(255, 73, 90, 247),
        ),
        padding: EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Carta 01
            Column(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Image.network(
                      'https://i.pinimg.com/564x/2e/fe/0d/2efe0d53dd2799777a951e26af018381.jpg',
                      width: 90,
                      height: 180,
                    ),
                  ),
                ),
              ],
            ),
            // Carta 02
            Column(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 52),
                  child: Center(
                    child: Image.network(
                      'https://i.pinimg.com/564x/2e/fe/0d/2efe0d53dd2799777a951e26af018381.jpg',
                      width: 90,
                      height: 180,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ));
}

Widget campo() {
  var atk = 1000;
  return Container(
    width: 120,
    height: 210,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.black, width: 3),
      color: Colors.transparent,
    ),
    child: Center(child: Text('Vazio')),
  );
}

class Duelo extends StatelessWidget {
  dynamic jdado;
  Duelo(this.jdado);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start, // Alinha mesaPc() no topo
          children: [
            mesaPc(),
            Expanded(child: Container()), // Ocupa espaço restante
            mesa1(jdado),
          ],
        ),
        Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: EdgeInsets.fromLTRB(35, 110, 0, 20), child: campo())),
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(24),
              primary: Colors.red,
            ),
            child: Icon(
              Icons.crop_square_sharp,
              size: 32,
              color: Colors.white,
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 35, 125), child: campo())),
      ],
    );
  }
}
