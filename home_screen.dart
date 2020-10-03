import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments; //uses arguments stated in loading file
    //set background
    String bgImage = data['isDaytime'] ? 'day.png' : 'night.png'; //if it is day use day image if not use night image
    Color bgColor = data['isDaytime'] ? Colors.blue : Colors.indigo[700]; //if it is day use lighter blue if not use darker blue

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea( //moved text into a visible area of the screen
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover,  //makes sure that the image covers the entire screen
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
              child: Column(
                children: <Widget>[
                  FlatButton.icon(
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, '/location'); //when in location screen it will wait until a button is pushed then go back to home
                      setState(() { //sets the new location
                        data = {
                          'Time' : result['Time'],
                          'Location' : result['Location'],
                          'isDaytime' : result['isDaytime'],
                          'flag' : result['Flag'],
                        };
                      });
                    },
                    icon: Icon(
                        Icons.edit_location,
                      color: Colors.grey[300],
                    ),
                    label: Text(
                        'Edit Location',
                      style: TextStyle(
                        color: Colors.grey[300]
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data['Location'],
                        style: TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    data['Time'],
                    style: TextStyle(
                      fontSize: 66.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
