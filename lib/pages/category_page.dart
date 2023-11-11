import 'package:flutter/material.dart';
import 'package:kutuphaneapp/Constants/constants.dart';
import 'package:kutuphaneapp/pages/content_page.dart';
import 'package:scaled_list/scaled_list.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.myTheme.scaffoldBackgroundColor,
      body: Center(
        child: ScaledList(
          unSelectedCardHeightRatio: 0.3,
          itemCount: categories.length,
          itemColor: (index) {
            return Constants
                .kMixedColors[index % Constants.kMixedColors.length];
          },
          itemBuilder: (index, selectedIndex) {
            final category = categories[index];
            return InkWell(
              onTap: () {
                final selectedCategoryName = categories[index].name;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ContentPage(CategoryChapter: selectedCategoryName),
                    ));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: selectedIndex == index ? 150 : 140,
                    child: Image.asset(category.image),
                  ),
                  const SizedBox(height: 35),
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
    );
  }

  static final List<Category> categories = [
    Category(image: "assets/images/roman.png", name: "ROMAN"),
    Category(image: "assets/images/hikaye.png", name: "HİKAYE"),
    Category(image: "assets/images/ansiklopedi.png", name: "ANSİKLOPEDİ"),
    Category(image: "assets/images/biyografi.png", name: "BİYOGRAFİ"),
    Category(image: "assets/images/siir.png", name: "ŞİİRLER"),
    Category(image: "assets/images/korku.png", name: "KORKU"),
    Category(image: "assets/images/polisiye.png", name: "POLİSİYE"),
  ];
}

class Category {
  final String image;
  final String name;

  Category({required this.image, required this.name});
}
