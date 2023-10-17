import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Weather? _weather;
  final openWeather = WeatherFactory('bf3cfc2ad5ced7ab66ce44cb3875a3ca');
  String cityName = '';

  getWeather() async {
    try {
      _weather = await openWeather.currentWeatherByCityName(cityName);
      setState(() {});
    } catch (e) {
      print('the eorr is  $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search by City name'),
        backgroundColor: Colors.cyan,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(22.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  cityName = value;
                });
              },
              decoration: InputDecoration(
                  suffix: IconButton(
                      onPressed: () {
                        getWeather();
                      },
                      icon: Icon(
                        Icons.search,
                        color: Colors.cyan,
                      )),
                  hintText: 'search city',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0))),
            ),
          ),
          Expanded(
              child: _weather != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${_weather!.temperature!.celsius!.round()}C',
                          style: TextStyle(fontSize: 35),
                        ),
                        Text('${_weather!.weatherDescription}')
                      ],
                    )
                  : SizedBox())
        ],
      ),
    );
  }
}
