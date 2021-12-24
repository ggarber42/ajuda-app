import 'package:ajuda_app/model/weather_report.dart';
import 'package:ajuda_app/model/album.dart';
import 'package:ajuda_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:ajuda_app/widgets/navigation_drawer_widget.dart';

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

  @override
  void initState() {
    super.initState();
  }

  Future<WeatherReport> getData() async{
   final WeatherReport data = await Utils.fetchWeatherReport();
   print(data.toString());
   return data;
  }

  void getJSON() async{
  //  final Album data = await Utils.fetchAlbum();
  // print(data);
  print('aqui');
  Utils.fetchEvents();
  }


  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text(MyApp.title),
        ),
        body: Column(
          children: [
            Container(
              child: RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('Rotina'),
                onPressed: getJSON,
              ),
            ),
          ],
        ),
      );
}
