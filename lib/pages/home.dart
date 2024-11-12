import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>? ?? {};
    // data = ModalRoute.of(context)!.settings.arguments as Map; //same as above

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            OverflowBar(
              children: <Widget>[
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/location');
                    },
                  icon: const Icon(Icons.edit_location),
                  label: Text('Set Location'),
                ),
              ],
              ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  Uri.decodeComponent(data['location']),
                  style: const TextStyle(
                    fontSize: 20.0,
                    letterSpacing: 2.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  data['time'],
                  style: const TextStyle(
                    fontSize: 66.0,
                    letterSpacing: 2.0,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}