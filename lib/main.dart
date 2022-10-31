import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:wther_app/modal/weatherModal.dart';
import 'package:wther_app/services/weather_api.dart';
import 'package:wther_app/weather/additonal_info.dart';
import 'package:wther_app/weather/currentweather.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  weatherapiClient client = weatherapiClient();
  Weather? data;
  @override
  Future<void> getData() async {
    data = await client.getCurrentWeather("Georgia");
    print(data!.cityName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFf9f9f9),
        appBar: AppBar(
          title: const Text(
            'Weather App',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.menu),
            color: Colors.black,
            onPressed: () {},
          ),
        ),
        body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      currentWeather(Icons.wb_sunny_rounded, "${data!.temp}", "${data!.cityName}"),
                      Text(
                        "Additional Info",
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 37, 25, 25)),
                      ),
                      Divider(),
                      SizedBox(height: 20.0),
                      additionalInfo("${data!.wind}", "${data!.humidity}", "${data!.pressure}", "${data!.feels_like}")
                    ]);
              }else if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }else{
                return Center(child: Text("Error"));
              }
              return Container();
            }));
  }
}
