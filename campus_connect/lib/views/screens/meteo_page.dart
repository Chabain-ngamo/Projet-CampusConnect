import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/views/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class MeteoPage extends StatefulWidget {
  const MeteoPage({super.key});

  @override
  State<MeteoPage> createState() => _MeteoPageState();
}

class _MeteoPageState extends State<MeteoPage> {
  late Size mediaSize;
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  List<Weather>? _weathers;
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("Douala").then((w){
      setState(() {
        _weather = w;
      });
    });
    _wf.fiveDayForecastByCityName("Douala").then((w){
      setState(() {
        _weathers = w;
      });
    });
    /*_getWeatherForecast();*/
  }

  /*Future<void> _getWeatherForecast() async {
    try {
      _weathers = await _wf.fiveDayForecastByCityName("Douala");
      setState(() {});
    } catch (e) {
      setState(() {});
    }
  }*/

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    if (_weathers == null) {
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/nuage2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
          ],
        ),
      );
    }
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/nuage2.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  _buildBottom(),
                ],
              ),
            ),
            ButtonBackWidget()
          ],
        ),
      ),
    );
  }

  /*Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Météo",
          style: TextStyle(
            color: darkColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
        const SizedBox(height: 50),
        _buildWeatherForecast(),
      ],
    );
  }*/

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: _buildForm(),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Météo",
          style: TextStyle(
            color: darkColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
        const SizedBox(height: 20),
        _buildSingleData(),
        const SizedBox(height: 30),
        _buildWeatherForecast(),
      ],
    );
  }

  Widget _buildSingleData() {
    String location = _weather?.areaName ?? "";
    DateTime? now = _weather?.date;

    if (_weather == null || now == null) {
        // Afficher un message ou un indicateur de chargement
        return Center(
            child: Text(
                'Données météo indisponibles.',
                style: TextStyle(color: darkColor, fontSize: 24),
            ),
        );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Text(
                location,
                style: const TextStyle(color: darkColor, fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    DateFormat("EEEE").format(now),
                    style: const TextStyle(color: darkColor, fontSize: 20, fontWeight: FontWeight.w400, fontFamily: 'Roboto'),
                  ),
                  const SizedBox(width: 5,),
                  Text(
                    DateFormat("d/M/y").format(now),
                    style: const TextStyle(color: darkColor, fontSize: 20, fontWeight: FontWeight.w400, fontFamily: 'Roboto'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                "${_weather?.temperature?.celsius?.toStringAsFixed(0)}°C",
                style: const TextStyle(
                    color: campuscolor, fontSize: 96, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
              ),
            ),
          ],
        ),
      ],
    );
}



  Widget _buildWeatherForecast() {
    if (_weathers == null) {
        return Center(
            child: Text(
                'Prévisions météorologiques indisponibles.',
                style: TextStyle(color: darkColor, fontSize: 24),
            ),
        );
    }

    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Prévisions sur une semaine",
            style: TextStyle(
                color: darkColor, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
          ),
        ),
        const SizedBox(height: 10),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: List.generate(7, (index) {
                final weather = _weathers![index];
                final dateTime = weather.date;

                if (dateTime == null) {
                    return const SizedBox.shrink();  // Ignore les entrées avec des dates nulles
                }

                final dayOfWeek = DateFormat('EEE').format(dateTime);
                final temperature = weather.temperature?.celsius?.toStringAsFixed(0);
                final iconUrl = "http://openweathermap.org/img/w/${weather.weatherIcon}.png";

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          dayOfWeek,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Image.network(
                          iconUrl,
                          width: 60,
                          height: 60,
                        ),
                        Text(
                          "$temperature°C",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    if (index < 6) const Divider(color: darkColor, thickness: 0.5),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    );
}

}
