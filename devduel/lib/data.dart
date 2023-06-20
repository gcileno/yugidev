import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'listas.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'data.dart';

enum TableStatus{idle,loading,ready,error,duelo,creditos,favorito} // tabela de status
//função para consumo da api
class DataService {
  final ValueNotifier<Map<String,dynamic>> tableStateNotifier = new ValueNotifier({'status':TableStatus.idle,'dataObjects':[]});

  void carregar(index) {
    final carregadores = [
      () => duelo(),
      () => loadCards({'': ''}),
      () => favoritos(),
      () => creditos(),
    ];
    tableStateNotifier.value = {

      'status': TableStatus.loading,

      'dataObjects': []

    };
    carregadores[index]();
  }

  void duelo() {
    tableStateNotifier.value = {

        'status': TableStatus.duelo,

        'dataObjects': []

      };

  }

  void creditos() {
    tableStateNotifier.value = {

        'status': TableStatus.creditos,

        'dataObjects': []

      };
  }
  
  Future<void> loadCards(Map<String, String> nv_parametro) async {
    var queryParameters = {'language': 'pt'};
    queryParameters.addAll(nv_parametro);
    var apiCartas = Uri(
        scheme: 'https',
        host: 'db.ygoprodeck.com',
        path: 'api/v7/cardinfo.php',
        queryParameters: queryParameters);

    var dados = await http.read(apiCartas);

    var jcards = jsonDecode(dados)["data"];

    tableStateNotifier.value = {

        'status': TableStatus.ready,

        'dataObjects': jcards

      };

//    tableStateNotifier.value = {
//      'status': 'ready',
//      'type': 'loadCards',
//      'data': jcards
//    };
  }

  void favoritos (){
    tableStateNotifier.value = {

    'status': TableStatus.favorito,

    'dataObjects': [MeusFavoritos]

  };
  }
}
