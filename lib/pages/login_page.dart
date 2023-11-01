import 'package:flutter/material.dart';
import 'package:kutuphaneapp/pages/category_page.dart';
import 'package:kutuphaneapp/pages/forget_password.dart';
import 'package:kutuphaneapp/pages/login_page.dart';
import 'package:kutuphaneapp/pages/new_account_page.dart';

import 'category_page.dart';
import 'forget_password.dart';
import 'new_account_page.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({super.key});

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  //ScreenUtil
  final bool selected = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var backgroundColor = Color.fromARGB(255, 249, 248, 245);
    var themeColor = Color(0xFF854700);
    var primaryColor = Color.fromARGB(255, 219, 117, 0);
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: backgroundColor,
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding:
              const EdgeInsets.only(left: 35.0, right: 35.0, top: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "BiblioHub",
                    style: TextStyle(
                      fontFamily: "AlbertusNova-Bold",
                      fontSize: 35,
                      color: Color.fromARGB(255, 133, 71, 0),
                    ),
                  ),
                  Container(
                    height: size.height * 0.4,
                    width: size.width * 0.4,
                    child: CircleAvatar(
                      child: Icon(
                        Icons.person,
                        size: size.height * 0.18,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: CustomTextFormField(
                      ("Kullanıcı Adı veya E-mail"),
                    ),
                  ),
                  const Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  CustomTextFormField("Şifre"),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewPassword(),
                            ));
                      },
                      child: const Text(
                        "Sifremi Unuttum",
                        style:
                        TextStyle(color: Color.fromARGB(255, 133, 71, 0)),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 179, 179, 68),
                      shape: StadiumBorder(),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryPage(),
                          ));
                    },
                    child: Text("Giris Yap"),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 179, 179, 68),
                        shape: StadiumBorder(),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => (NewAccountPage()),
                            ));
                      },
                      child: Text("Hesabım Yok"))
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
        maxLength: value,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
        ),
      ),
    );
  }
}
