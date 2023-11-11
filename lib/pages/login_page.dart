// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kutuphaneapp/pages/category_page.dart';
import 'package:kutuphaneapp/pages/forget_password.dart';
import 'package:kutuphaneapp/pages/new_account_page.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({super.key});

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  late TextEditingController MailData;
  late TextEditingController LoginPassword;
  //ScreenUtil
  final bool selected = false;
  late FirebaseAuth auth;
  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
    MailData = TextEditingController();
    LoginPassword = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var backgroundColor = const Color.fromARGB(255, 249, 248, 245);
    var primaryColor = const Color.fromARGB(255, 219, 117, 0);
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
                      fontFamily: "AlbertusNova",
                      fontSize: 35,
                      color: Color.fromARGB(255, 133, 71, 0),
                    ),
                  ),
                  SizedBox(
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
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: CustomTextFormField("E-mail", MailData),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  CustomTextFormField("Şifre", LoginPassword,
                      obscureText: true),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NewPassword(),
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
                      backgroundColor: const Color.fromARGB(255, 179, 179, 68),
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () async {
                      try {
                        var userCredential =
                            await auth.signInWithEmailAndPassword(
                          email: MailData.text,
                          password: LoginPassword.text,
                        );

                        if (userCredential.user != null) {
                          // Kullanıcı başarıyla giriş yaptı.
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryPage(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Giriş başarısız. Kullanıcı bulunamadı."),
                            ),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "Giriş başarısız. Kullanıcı adı veya şifre hatalı."),
                          ),
                        );
                      }
                    },
                    child: const Text("Giriş Yap"),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 179, 179, 68),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => (NewAccountPage()),
                            ));
                      },
                      child: const Text("Hesabım Yok")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  CustomTextFormField(String? hintText, TextEditingController controller,
      {int? value, bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        maxLength: value,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
        ),
      ),
    );
  }
}
