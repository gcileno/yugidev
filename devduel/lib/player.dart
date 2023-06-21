import 'dart:math';

class Player {
  final String nome;
  final int hp = 4000;
  final List<Card> hand = [];
  final Deck deck;

  Player(this.nome, this.deck);

  void puxarCarta() {
    if (deck.baralho.length >= 2) {
      deck.baralho.shuffle(Random());
      hand.addAll(deck.baralho.take(2));
      deck.baralho.removeRange(0, 2);
    } else {
      // Lidar com o caso em que não há cartas suficientes no deck
      print("Não há cartas suficientes no deck para preencher a mão.");
    }
  }
}

class Card {
  final String image;
  final String nome;
  final int atk;
  final int def;

  Card(this.image, this.nome, this.atk, this.def);
}

class Deck {
  final List<Card> baralho;

  Deck(this.baralho);
}

//
//funções para criar baralhos e cards
//
Deck criarBaralho(List<dynamic> listaCartas) {
  List<Card> cartas = [];

  // Criar uma instância de Random
  Random random = Random();

  // Embaralhar as cartas de forma aleatória
  List<dynamic> sorteio = List.from(listaCartas)..shuffle(random);

  for (var i = 0; i < 10 && i < sorteio.length; i++) {
    var cartaData = sorteio[i];
    //criando a carta
    Card carta = Card(cartaData['card_images'][0]['image_url_small'],
        cartaData['name'], cartaData['atk'] ?? 0, cartaData['def'] ?? 0);

    //inserindo no baralho
    cartas.add(carta);
  }

  return Deck(cartas);
}
