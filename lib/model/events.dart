import 'dart:math';

import 'package:ajuda_app/model/event.dart';

class Events {
  List<Event> eventList;

  Events({
    required this.eventList
  });

 void printEvents(){
   eventList.forEach((event) {
      print(event);
   });
 }
}