import 'dart:convert';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:ajuda_app/utils/user_secure_storage.dart';
import 'package:http/http.dart' as http;

class Utils {

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
    text += 'Acabouuu k k k k k k.';
    await tts.speak(text);
  }
}
