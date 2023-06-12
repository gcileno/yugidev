import 'package:flutter/material.dart';

List<Icon> iconico = [
  Icon(Icons.close_sharp),
  Icon(Icons.manage_search),
  Icon(Icons.info_outline),
];

var typeopc = [
  'Skill Card',
  'Spell Card',
  'Trap Card',
  'Normal Monster',
  'Normal Tuner Monster',
  'Effect Monster',
  'Tuner Monster',
  'Flip Monster',
  'Flip Effect Monster',
  'Flip Tuner Effect Monster',
  'Spirit Monster',
  'Union Effect Monster',
  'Gemini Monster',
  'Pendulum Effect Monster',
  'Pendulum Normal Monster',
  'Pendulum Tuner Effect Monster',
  'Ritual Monster',
  'Ritual Effect Monster',
  'Toon Monster',
  'Fusion Monster',
  'Synchro Monster',
  'Synchro Tuner Monster',
  'Synchro Pendulum Effect Monster',
  'XYZ Monster',
  'XYZ Pendulum Effect Monster',
  'Link Monster',
  'Pendulum Flip Effect Monster',
  'Pendulum Effect Fusion Monster',
  'Token'
];

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

void launch(String s) {}
