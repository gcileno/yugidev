import 'dart:math';

class Player {
  final String nome;
  final int hp = 4000;
  final List<Card> hand;
  final Deck deck;

  Player(this.nome, this.hand, this.deck);

  void fillHandFromDeck() {
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
  final String nome;
  final int atk;
  final int def;

  Card(this.nome, this.atk, this.def);
}

class Deck {
  final List<Card> baralho;

  Deck(this.baralho);
}