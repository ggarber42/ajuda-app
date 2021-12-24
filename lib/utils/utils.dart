import 'dart:convert';
import 'dart:math';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:ajuda_app/model/weather_report.dart';
import 'package:ajuda_app/model/album.dart';
import 'package:http/http.dart' as http;

class Utils {
  static void getAgenda() {}

  static Future<WeatherReport> fetchWeatherReport() async {
    const url =
        'https://api.openweathermap.org/data/2.5/forecast?id=3452925&&cnt=1&lang=pt_br&appid=6ac82a198c4090f0865d399a2ee70553';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return WeatherReport.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  static Future<Album> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

    if (response.statusCode == 200) {
      return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static void fetchEvents() async {
    final FlutterTts tts = FlutterTts();
    await tts.awaitSpeakCompletion(true);
    final accesToken =
        'ya29.a0ARrdaM9LNqdAdo2cPLOWAaXLqOhP5cpKxXXuoV0NXfDd38VgWfNXjc_bK-neGusm0RX6F9DGA4BT2XEcYNyi_tXZLyUWK5qB0hKJZVj9t-wWMkynjN15zv0dKq75WdDpAcEbmIgmFG61hqnoYfKl3EcPLXsECw';
    final response = await http.get(
        Uri.parse(
            'https://www.googleapis.com/calendar/v3/calendars/guilherme.garber@linx.com.br/events?singleEvents=true&timeMin=2021-12-24T17:59:17.919Z&timeMax=2021-12-31T17:59:17.919Z&orderby=startTime&singleEvents=true'),
        headers: {'Authorization': 'Bearer $accesToken'});
    var events = jsonDecode(response.body)['items'];
    var text = '';
    events.forEach((elem) {
      print(elem['summary']);
      print(elem['start']['dateTime']);
      text += 'Nome do evento:  ';
      text += elem['summary'].toString() + '.';
      text += 'Quando?  ';
      text += elem['start']['dateTime'].toString() + '  .';
    });
    await tts.speak(text);
  }
}
