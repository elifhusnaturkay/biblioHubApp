// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kutuphaneapp/pages/category_page.dart';

class NewAccountPage extends StatefulWidget {
  static String? asc;
  static String? ep;
  static String? sfr;
  static String? sfr2;
  static String? cvp;

  const NewAccountPage({super.key});

  @override
  State<NewAccountPage> createState() => _NewAccountPageState();
}

class _NewAccountPageState extends State<NewAccountPage> {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  late FirebaseAuth auth;
  late TextEditingController adSoyadController;
  late TextEditingController epostaController;
  late TextEditingController sifreController;
  late TextEditingController sifreController2;
  late TextEditingController cevapController;
  String? selectedItem = 'Doğrulama sorusu seçin';

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
  }

  Widget customTextFormFieldMaker(
    String hintText,
    TextEditingController controller, {
    bool isPassword = false,
    TextInputType? keyboardtype,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: TextFormField(
        keyboardType: keyboardtype,
        controller: controller,
        style: const TextStyle(fontWeight: FontWeight.w400),
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }

  Widget dropDownBoxMaker(String? hintText) {
    const List<String> items = <String>[
      'Doğrulama sorusu seçin',
      'İlk evcil hayvanınızın adı',
      'İlkokul öğretmeninizin adı',
      'Doğdunuz mahallenin adı',
      'En sevdiğiniz renk'
    ];

    return Container(
      padding: const EdgeInsets.only(top: 10.0, bottom: 5),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        value: selectedItem,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedItem = newValue;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    adSoyadController = TextEditingController();
    epostaController = TextEditingController();
    sifreController = TextEditingController();
    sifreController2 = TextEditingController();
    cevapController = TextEditingController();
    var backgroundColor = const Color.fromARGB(255, 249, 248, 245);
    var themeColor = const Color(0xFF854700);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: backgroundColor,
          leading: Container(
            padding: const EdgeInsets.only(left: 60, top: 10, right: 60),
            child: Icon(
              Icons.account_circle_rounded,
              color: themeColor,
              size: 50,
            ),
          ),
          title: Container(
            padding: const EdgeInsets.only(
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
          color: const Color(0x0ff9f8f5),
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customTextFormFieldMaker("Ad - Soyad", adSoyadController),
                  customTextFormFieldMaker("E-posta", epostaController,
                      keyboardtype: TextInputType.emailAddress),
                  customTextFormFieldMaker("Şifre", sifreController,
                      isPassword: true),
                  customTextFormFieldMaker("Şifre Yeniden", sifreController2,
                      isPassword: true),
                  dropDownBoxMaker("Doğrulama sorusu"),
                  customTextFormFieldMaker(
                      "Doğrulama sorusu cevabı", cevapController),
                  Container(
                    padding: const EdgeInsets.only(top: 10.0),
                    width: 180,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 179, 179, 68),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () async {
                        NewAccountPage.asc = adSoyadController.text;
                        NewAccountPage.ep = epostaController.text;
                        NewAccountPage.sfr = sifreController.text;
                        NewAccountPage.sfr2 = sifreController2.text;
                        NewAccountPage.cvp = cevapController.text;

                        if (NewAccountPage.asc!.isEmpty ||
                            NewAccountPage.ep!.isEmpty ||
                            NewAccountPage.sfr!.isEmpty ||
                            NewAccountPage.sfr2!.isEmpty ||
                            NewAccountPage.cvp!.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Lütfen Boş Alanları Doldurun"),
                          ));
                          return;
                        }

                        if (NewAccountPage.sfr!.length < 6) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Şifre en az 6 karakter içermelidir."),
                            ),
                          );
                          return;
                        }

                        if (NewAccountPage.sfr! != NewAccountPage.sfr2!) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Şifreler uyuşmuyor."),
                            ),
                          );
                          return;
                        }

                        try {
                          // Firebase Authentication kullanarak giriş veya kayıt işlemi yapıldı
                          var userCredential =
                              await auth.createUserWithEmailAndPassword(
                            email: NewAccountPage.ep!,
                            password: NewAccountPage.sfr!,
                          );

                          if (userCredential.user != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CategoryPage(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Giriş başarısız. Kullanıcı oluşturulamadı."),
                              ),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Kayıt oluşturulamadı. Lütfen bütün alanları doldurun ve doğruluğundan emin olun."),
                            ),
                          );
                        }
                        ;
                      },
                      child: const Text("Kayıt Ol"),
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
}
