import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  String time = ''; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint prefix
  bool isDaytime = true; // true or false if daytime or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    //make the request
    Uri uri = Uri.parse('https://www.timeapi.io/api/timezone/zone?timeZone=${url}');
    Response response = await get(uri);
    Map data = jsonDecode(response.body);

    // print(data);
    //get properties from data

    String datetime = data['currentLocalTime'];
    dynamic offset = data['currentUtcOffset']['seconds']/3600;

    //create DateTime object
    DateTime now = DateTime.parse(data['currentLocalTime']);

    isDaytime = now.hour > 6 && now.hour < 20 ? true : false;

    //set the time property
    // time = now.toString();
    time = DateFormat.jm().format(now);
  }
}