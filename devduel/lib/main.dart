import 'mywidget.dart';
import 'package:flutter/material.dart';
import 'listas.dart';


void main() {
  runApp(app);
}

// minhas funções

MaterialApp app = MaterialApp(
    theme: ThemeData(primarySwatch: Colors.indigo),
    home: Scaffold(
        appBar: AppBar(title: Text("Dev Duel")),
        body: ValueListenableBuilder(
            valueListenable: dataService.tableStateNotifier,
            builder: (_, value, __) {
              //if (value['type'] == 'loadCards'){}
              return CardsWidget(value);
            }),
        bottomNavigationBar: Nav(
            meuincone: iconico, itemSelectedCallback: dataService.carregar)));
