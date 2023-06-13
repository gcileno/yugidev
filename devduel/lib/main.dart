import 'mywidget.dart';
import 'package:flutter/material.dart';
import 'listas.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final tela = Telas();

void main() {
  runApp(app);
}

// minhas funções

MaterialApp app = MaterialApp(
    theme: ThemeData(primarySwatch: Colors.indigo),
    home: Scaffold(
        appBar: AppBar(title: Text("Dev Duel")),
        body: ValueListenableBuilder(
            valueListenable: tela.tableStateNotifier,
            builder: (_, value, __) {
              return MostrarDadosState(value.cast());
            }),
        bottomNavigationBar:
            Nav(meuincone: iconico, itemSelectedCallback: tela.carregar)));
