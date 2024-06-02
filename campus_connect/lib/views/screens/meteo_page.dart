import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/views/widgets/back_button.dart';
import 'package:flutter/material.dart';

class MeteoPage extends StatefulWidget {
  const MeteoPage({super.key});

  @override
  State<MeteoPage> createState() => _MeteoPageState();
}

class _MeteoPageState extends State<MeteoPage> {
  late Size mediaSize;

  @override
Widget build(BuildContext context) {
  mediaSize = MediaQuery.of(context).size;
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/nuage2.png'), // Remplacez par le chemin de votre image
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
                SizedBox(height: 50,),
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
          "Meteo",
          style: TextStyle(
              color: darkColor, fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
        ),
        const SizedBox(height: 50),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Center(
              child: Text(
                "Douala",
                style: TextStyle(
                    color: darkColor, fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "31°",
                style: TextStyle(
                    color: campuscolor, fontSize: 96, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Prévisions sur une semaine",
                style: TextStyle(
                    color: darkColor, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
        _buildMeteoCard(),
      ],
    );
  }



  Widget _buildMeteoCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMeteoRow(),
            const Divider(color: darkColor,thickness: 0.5,),
            _buildMeteoRow(),
            const Divider(color: darkColor,thickness: 0.5,),
            _buildMeteoRow(),
            const Divider(color: darkColor,thickness: 0.5,),
            _buildMeteoRow(),
            const Divider(color: darkColor,thickness: 0.5,),
            _buildMeteoRow(),
            const Divider(color: darkColor,thickness: 0.5,),
            _buildMeteoRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildMeteoRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Lun",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Image.asset(
          'assets/icons_meteo.png',
          width: 60,
          height: 60,
        ),
        const Text(
          "31°",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

}