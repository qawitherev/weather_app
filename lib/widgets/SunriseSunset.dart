import 'package:flutter/material.dart';

class SunriseSunset extends StatelessWidget {
  const SunriseSunset({Key? key}) : super(key: key);

  final TextStyle _style1 =
      const TextStyle(fontSize: 30, fontWeight: FontWeight.w500);

  Widget _sunriseSunsetBuilder(
      {required String header, required String body, required IconData icon}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.blue,
          size: 44,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              header,
              style: _style1,
            ),
            Text(
              body,
              style: _style1.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10.0),
      child: const Text('This is a text'),
    );
  }
}
