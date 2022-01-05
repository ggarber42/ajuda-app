import 'dart:convert';
import 'dart:math';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:ajuda_app/utils/user_secure_storage.dart';

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

static getAccesToken() async{
    final clientId = await UserSecureStorage.getClientId() ?? '';
    final clientSecret = await UserSecureStorage.getClientSecret() ?? '';
    final refreshToken = await UserSecureStorage.getRefreshToken() ?? '';
    final response = await http.post(
    Uri.parse('https://oauth2.googleapis.com/token'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'client_id': clientId,
      'client_secret': clientSecret,
      'refresh_token': refreshToken,
      'grant_type': 'refresh_token'
    }),
  );
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['access_token'];
  } else {
    throw Exception('Failed Request.');
  }
  }

  static void fetchEvents(accesToken) async {
    final FlutterTts tts = FlutterTts();
    await tts.awaitSpeakCompletion(true);
    var now = DateTime.now();
    var oneWeekFromNow = now.add(const Duration(days: 7));
    var nowIso = now.toIso8601String() + 'Z';
    var oneWeekFromNowIso = oneWeekFromNow.toIso8601String() + 'Z';
    final response = await http.get(
        Uri.parse(
            'https://www.googleapis.com/calendar/v3/calendars/guilherme.garber@linx.com.br/events?singleEvents=true&timeMin=$nowIso&timeMax=$oneWeekFromNowIso&orderby=startTime&singleEvents=true'),
        headers: {'Authorization': 'Bearer $accesToken'});
    final events = jsonDecode(response.body)['items'];
    var text = '';
    events.forEach((elem) {
      print(elem['summary']);
      print(elem['start']['dateTime']);
      text += 'Evento:     .';
      text += elem['summary'].toString() + '       .';
      var date = DateTime.parse(elem['start']['dateTime'].toString());
      String weekDay;
      if(date.weekday == 1){
        weekDay = 'Segunda';
      } else if(date.weekday == 2){
        weekDay = 'Terça';
      } else if(date.weekday == 3){
        weekDay = 'Quarta';
      } else if(date.weekday == 4){
        weekDay = 'Quinta';
      } else if(date.weekday == 5){
        weekDay = 'Sexta';
      } else {
        weekDay = '';
      }
      var hour = elem['start']['dateTime'].toString().split("T")[1].split("-")[0];
      var monthDay = date.day;
      var month = date.month;
      text += 'Dia $monthDay   .';
      text += 'Mês $month    .';
      text += 'Dia da semana $weekDay    .';
      text += 'Hora $hour  .';
    });
    text += 'Acabouuu k k k k k.';
    await tts.speak(text);
  }
}
