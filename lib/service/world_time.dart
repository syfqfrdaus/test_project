import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String? location; // location name for UI
  String? time; // the time in that location
  String? flag; // url to an asset flag icon
  String? country; // location url for api endpoint
  bool? isDayTime;

  WorldTime({this.location, this.flag, this.country});

  Future<void> getTime() async {

    try {

      final url = Uri.parse('http://worldtimeapi.org/api/timezone/$country'); //target url

      Response response = await get(url);//fetch the time based on the url
      Map data = jsonDecode(response.body); // decode json data into each part and not in string list anymore

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0, 3);
      //print(datetime);
      //print(offset);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDayTime = now.hour > 6 && now.hour < 19 ? true : false;

      time = DateFormat.jm().format(now);

    }
    catch (e) {
      print('Error in fetching time : $e');
      time = 'Could Not Get The Time!';
    }

  }
}
