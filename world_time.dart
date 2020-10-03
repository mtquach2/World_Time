import 'package:http/http.dart';  //imports http package
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location;  //location name for the UI
  String time;  //time in that location
  String flag;  //URL to an asset flag icon
  String url; //location URL for API endpoint
  bool isDaytime; //true or false if daytime or not

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {

    try{
      //make the request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');  //gets time from api
      Map data = jsonDecode(response.body);

      //get properties from data
      String datetime = data['datetime']; //gets datetime
      String offset = data['utc_offset'].substring(0,3);  //gets offset of time but just the number

      //create DateTime object
      DateTime now = DateTime.parse(datetime);  //creates DateTime object
      now = now.add(Duration(hours: int.parse(offset))); //gets the time as of now at the location

      //set the time property
      isDaytime = now.hour > 5 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e){
      print('Caught Error: $e');
      time = 'Could not get Time Data';
    }


  }

}
