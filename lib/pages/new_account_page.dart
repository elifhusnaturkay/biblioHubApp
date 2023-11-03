import 'package:flutter/material.dart';
import 'package:kutuphaneapp/pages/category_page.dart';
import 'package:kutuphaneapp/pages/forget_password.dart';
import 'package:kutuphaneapp/pages/login_page.dart';

class NewAccountPage extends StatefulWidget {
  const NewAccountPage({super.key});

  @override
  State<NewAccountPage> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<NewAccountPage> {
  //ScreenUtil
  final bool selected = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var backgroundColor = Color.fromARGB(255, 249, 248, 245);
    var themeColor = Color(0xFF854700);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: backgroundColor,
          leading: Container(
            padding: EdgeInsets.only(left: 60, top: 10, right: 60),
            child: Icon(
              Icons.account_circle_rounded,
              color: themeColor,
              size: 50,
            ),
          ),
          title: Container(
            padding: EdgeInsets.only(
              left: 40,
              top: 15,
              right: 40,
            ),
            child: const Text(
              "BiblioHub",
              style: TextStyle(
                color: Color(0xFF854700),
                fontSize: 40,
              ),
            ),
          ),
        ),
        body: Container(
          color: Color(0xF9F8F5),
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customTextFormFieldMaker("Ad - Soyad"),
                  customTextFormFieldMaker("Kullanıcı Adı"),
                  customTextFormFieldMaker("E-posta"),
                  customTextFormFieldMaker("Şifre"),
                  customTextFormFieldMaker("Şifre Yeniden"),
                  dropDownBoxMaker("Doğrulama sorusu"),
                  customTextFormFieldMaker("Doğrulama sorusu cevabı"),
                  Container(
                    padding: EdgeInsets.only(top: 10.0),
                    width: 180,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 179, 179, 68),
                        shape: StadiumBorder(),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPageScreen(),
                            ));
                      },
                      child: Text("Kayıt Ol"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  CustomTextFormField(String? hintText, {int? value}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: TextFormField(
        style: TextStyle(fontWeight: FontWeight.w400),
        maxLength: value,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
        ),
      ),
    );
  }

  customTextFormFieldMaker(String boxOfName) {
    return Container(
      padding: EdgeInsets.only(bottom: 5.0),
      child: CustomTextFormField(
        (boxOfName),
      ),
    );
  }

  dropDownBoxMaker(String? hintText, {int? value}) {
    const List<String> items = <String>[
      'Doğrulama sorusu seçin',
      'İlk evcil hayvanınızın adı',
      'İlkokul öğretmeninizin adı',
      'Doğdunuz mahallenin adı',
      'En sevdiğiniz renk'
    ];
    String? selectedItem = 'Doğrulama sorusu seçin';
    padding:
    const EdgeInsets.only(
      bottom: 5.0,
    );
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 5),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
        ),
        value: selectedItem,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            selectedItem = newValue;
          }
        },
      ),
    );
  }
}
