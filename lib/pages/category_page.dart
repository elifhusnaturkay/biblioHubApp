import 'package:flutter/material.dart';
import 'package:kutuphaneapp/pages/content_page.dart';
import 'package:kutuphaneapp/pages/profile_page.dart';
import 'package:scaled_list/scaled_list.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          body: Center(
            child: ScaledList(
              unSelectedCardHeightRatio: 0.3,
              itemCount: categories.length,
              itemColor: (index) {
                return kMixedColors[index % kMixedColors.length];
              },
              itemBuilder: (index, selectedIndex) {
                final category = categories[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContentPage(),
                        ));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: selectedIndex == index ? 150 : 140,
                        child: Image.asset(category.image),
                      ),
                      SizedBox(height: 35),
                      Text(
                        category.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: selectedIndex == index ? 35 : 20),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        
        ));
  }

  final List<Color> kMixedColors = [
    Color(0xff71A5D7),
    Color(0xff72CCD4),
    Color(0xffFBAB57),
    Color(0xffdc0b5a),
    Color(0xff962D17),
    Color(0xffc657fb),
    Color(0xff1220cb),
  ];

  final List<Category> categories = [
    Category(image: "assets/images/image.jpg", name: "ROMAN"),
    Category(image: "assets/images/image.jpg", name: "HİKAYE"),
    Category(image: "assets/images/image.jpg", name: "ANSİKLOPEDİ"),
    Category(image: "assets/images/image.jpg", name: "BİYOGRAFİ"),
    Category(image: "assets/images/image.jpg", name: "ŞİİRLER"),
    Category(image: "assets/images/image.jpg", name: "KORKU"),
  ];
}

class Category {
  final String image;
  final String name;

  Category({required this.image, required this.name});
}
