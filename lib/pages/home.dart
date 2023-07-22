import 'dart:convert';

import 'package:http/http.dart' as http;

import 'dart:math';

import 'package:flutter/material.dart';
import '../utils/advices.dart';

class AdvicesPage extends StatefulWidget {
  const AdvicesPage({super.key});

  @override
  State<AdvicesPage> createState() => AdvicesPageState();
}

class AdvicesPageState extends State<AdvicesPage> {
  bool language = true;
  String advice = '';
  String autorAdvice = '';

  getSpanishAdvices() {
    int longitud = advices.length - 1;
    int index = Random().nextInt(longitud - 0 + 1) + 0;
    setState(
      () {
        advice = advices[index][0];
        autorAdvice = advices[index][1];
      },
    );
  }

  getEnglishAdvices() async {
    await http
        .get(
      Uri.parse('https://api.adviceslip.com/advice'),
    )
        .then(
      (res) {
        var apiResponse = jsonDecode(res.body);
        setState(
          () {
            advice = apiResponse['slip']['advice'];
            autorAdvice = apiResponse['slip']['id'].toString();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    // double height = size.height;
    // Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: const Color(0xff1F2631),
          child: Center(
            child: Container(
              width: width * .80,
              decoration: BoxDecoration(
                color: const Color(0x0f313a49),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(color: Colors.white12, blurRadius: 0.4)
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Positioned(
                    top: 10,
                    child: Text(
                      'ADVICE',
                      style: TextStyle(
                        color: Color(0xff4EFFAB),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 60,
                      horizontal: 10,
                    ),
                    child: Text(
                      advice,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: Text(
                      autorAdvice,
                      style: const TextStyle(
                        color: Color(0xff4EFFAB),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 150,
          child: Row(
            children: [
              Text(
                'Spanish',
                style: language
                    ? const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4EFFAB),
                      )
                    : const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white12,
                      ),
              ),
              const SizedBox(width: 20),
              Switch(
                activeColor: const Color(0xff4EFFAB),
                value: language,
                onChanged: (value) {
                  setState(() {
                    language = value;
                  });
                },
              ),
              const SizedBox(width: 20),
              Text(
                'English',
                style: language
                    ? const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white12,
                      )
                    : const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4EFFAB),
                      ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 50,
          child: GestureDetector(
            onTap: () {
              language ? getSpanishAdvices() : getEnglishAdvices();
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xff4EFFAB),
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(
                Icons.navigate_next,
                size: 50,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
