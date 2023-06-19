import 'mywidget.dart';
import 'package:flutter/material.dart';
import 'listas.dart';
import 'data.dart';


void main() {
  runApp(app);
}

// minhas funções

MaterialApp app = MaterialApp(
    theme: ThemeData(primarySwatch: Colors.indigo),
    home: Scaffold(
        appBar: AppBar(title: Text("Dev Duel")),
        body: ValueListenableBuilder<Map<String, dynamic>>(
            valueListenable: dataService.tableStateNotifier,
            builder: (_, value, __) {
              switch (value['status']) {
                case TableStatus.idle:
                  return Center(child: Text("Toque algum botão"));

                case TableStatus.loading:
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.red), // Cor do indicador
                      strokeWidth: 4.0, // Largura do círculo
                    ),
                  );

                case TableStatus.ready:
                  return CardsWidget(value['dataObjects']);
                case TableStatus.error:
                  return Text("Erro (X_X)");
                case TableStatus.duelo:
                  return Text("pagina de duelo");
                case TableStatus.creditos:
                  return ListView.builder(
                    itemCount.creditos.lenght,
                    itemBuilder:(context,index){
                      return ListTile(title:creditos[index],);
                      
                    },
                  );

              }

              return Text("...");
              //if (value['type'] == 'loadCards'){}
              //return CardsWidget(value);
            }),
        bottomNavigationBar: Nav(
            meuincone: iconico, itemSelectedCallback: dataService.carregar)));
