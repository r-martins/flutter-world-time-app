import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  Future<String> getBgImage(String location, bool isDaytime) async {
    String dayOrNight = isDaytime ? 'day' : 'night';
    String query = '$location $dayOrNight';
    Uri uri = Uri.parse('https://api.unsplash.com/photos/random?query=$query&client_id=${dotenv.env['UNSPLASH_API_KEY']}');
    Response response = await get(uri);
    Map data = jsonDecode(response.body) as Map;
    return data['urls']['full'];
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>? ?? {};

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<String>(
          future: getBgImage(data['location'], data['isDaytime']),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              String bgImage = snapshot.data ?? '';
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(bgImage),
                    fit: BoxFit.cover,
                  ),
                ),
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
                            backgroundColor: Colors.white30,
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
                            backgroundColor: Colors.white30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}