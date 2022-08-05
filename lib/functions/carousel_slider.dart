import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarouselSliderClass extends StatelessWidget {
  CarouselSliderClass({Key? key}) : super(key: key);

  final quotes = [
    'Money is a terrible master but an excellent servant.',
    'When prosperity comes do not use all of it.',
    'The more your money works for you , the less you have to work for money.',
    'Balancing your money is the key to have enough.',
    'Formal education will make you a living; self education will make you a fortune.',
    'Money is only a tool. It will take you where ever you wish, but it will not replace you as the driver.',
    'It\'s not how much money you make, but how much money you keep, how hard it works for you, and how many generations you keep it for.',
    'We make a living by what we get, but we make a life by whate we give.',
    'Money can\'t buy friends, but you can get a better class of enemy.',
    'The more you learn, the more you earn.',
  ];
  final authors = [
    'P.T. Barnum',
    'Confucius',
    'Idowu Koyenikan',
    'Elizabeth Warren Amelia',
    'Jim Rohn',
    'Ayn Rand',
    'Robert Kiyosaki',
    'Winston Churchill',
    'Spike Milligan',
    'Warren Buffet',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        options: CarouselOptions(
          viewportFraction: 1,

          autoPlay: true,
          // enlargeCenterPage: true,
          // enlargeStrategy: CenterPageEnlargeStrategy.height,
          autoPlayInterval: const Duration(seconds: 6),
        ),
        itemCount: quotes.length,
        itemBuilder: (context, index, realIndex) {
          final quotess = quotes[index];
          final authorss = authors[index];
          return SizedBox(
            child: quotesText(
              quote: quotess,
              authors: authorss,
            ),
          );
        });
  }

  quotesText({
    required String quote,
    required String authors,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '" $quote "',
          textAlign: TextAlign.center,
          style: GoogleFonts.allura(
            fontSize: 30,
            foreground: Paint()
              ..shader = const LinearGradient(
                colors: <Color>[
                  Color.fromARGB(255, 22, 23, 23),
                  Color.fromARGB(255, 62, 62, 62),
                  //add more color here.
                ],
              ).createShader(
                const Rect.fromLTWH(0.0, 0.0, 200.0, 100.0),
              ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("~$authors~"),
          ],
        )
      ],
    );
  }
}
