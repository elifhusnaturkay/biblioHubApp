import 'package:flutter/material.dart';
import 'package:kutuphaneapp/pages/add_book_page.dart';

class Constants {
  static ThemeData myTheme = ThemeData(
    primaryColor: const Color.fromARGB(255, 179, 179, 68),
    scaffoldBackgroundColor: const Color.fromARGB(255, 249, 248, 245),
    fontFamily: 'AlbertusNova',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'AlbertusNova',
        color: Color.fromARGB(255, 84, 112, 8),
        fontSize: 24.0,
      ),
      // Other text styles can be defined here.
    ),
  );

  static TextStyle titleTextStyle(double fontsize) {
    return TextStyle(
        fontFamily: 'AlbertusNova',
        color: const Color.fromARGB(255, 133, 71, 0),
        fontSize: fontsize);
  }

  static TextStyle contentTextStyle() {
    return const TextStyle(fontFamily: "ClearSans", fontSize: 18);
  }

  // ignore: non_constant_identifier_names
  static CustomElevatedButton(BuildContext context, var route, String text) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 179, 179, 68),
          shape: const StadiumBorder(),
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => route));
        },
        child: Text(text));
  }

  // ignore: non_constant_identifier_names
  static CustomFloatActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.black26,
      elevation: 0,
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    );
  }

  static addBook(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: const StadiumBorder(),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddBook(),
              ));
        },
        child: const Text("KİTAP EKLE"),
      ),
    );
  }

  static List<Color> kMixedColors = [
    const Color(0xff71A5D7),
    const Color(0xff72CCD4),
    const Color(0xffFBAB57),
    const Color(0xffdc0b5a),
    const Color(0xff962D17),
    const Color(0xffc657fb),
    const Color.fromARGB(188, 18, 144, 203),
  ];
  static customContainer(String imagesUrl, String kitapAdi, String yazar,
      int sayfaSayisi, int yazimTarihi) {
    return Column(
      children: [
        Container(
          width: 400,
          height: 200,
          color: Colors.orangeAccent,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  imagesUrl,
                  width: 150,
                  height: 190,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kitap Adi: $kitapAdi',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Yazar: $yazar',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Sayfa Sayısı: $sayfaSayisi',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Yazım Tarihi: $yazimTarihi',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
