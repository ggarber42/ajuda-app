import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ajuda_app/utils/utils.dart';
import 'package:ajuda_app/page/settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Ajuda-app';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: MainPage(),
      );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  void getAgenda() async {
    setState(() {
      isLoading = true;
    });
    final accesToken = await Utils.getAccesToken();
    Utils.fetchEvents(accesToken);
    Timer(Duration(milliseconds: 1000), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  void handlePopupSelect(result) {
    switch (result) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsPage()),
        );
        break;
      default:
        print('impossivel');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(MyApp.title),
          actions: <Widget>[
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text("Configurações"),
                  value: 1,
                ),
              ],
              onSelected: handlePopupSelect,
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(10, 100, 10, 10),
              child: RaisedButton(
                color: Colors.blue[200],
                textColor: Colors.white,
                child:isLoading
                ? CircularProgressIndicator(color:Colors.white)
                : Text('Agenda'),
                onPressed: getAgenda,
              ),
            ),
          ],
        ),
      );
}
