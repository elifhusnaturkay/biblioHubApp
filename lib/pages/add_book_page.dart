import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:kutuphaneapp/pages/login_page.dart';

class AddBook extends StatefulWidget {
  const AddBook({super.key});

  @override
  State<AddBook> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<AddBook> {
  //ScreenUtil
  final bool selected = false;
  @override
  Widget build(BuildContext context) {
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
              padding:
                  const EdgeInsets.only(left: 35.0, right: 35.0, top: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Kitap Ekle",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  dropDownBoxMaker("Kitap Türü"),
                  customTextFormFieldMaker("Kitap Adı"),
                  customTextFormFieldMaker("Sayfa Sayısı"),
                  customTextFormFieldMaker("Kitap Açıklaması"),
                  customTextFormFieldMaker("Yazar Adı"),
                  dateBoxMaker("Okunma Başlama Tarihi"),
                  dateBoxMaker("Okunma Bitiş Tarihi"),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: 180,
                    height: 60,
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
                      child: Text("Kitap Ekle"),
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
      'Kitap türü seçin',
      'ROMAN',
      'HİKAYE',
      'ANSİKLOPEDİ',
      'BİYOGRAFİ',
      'ŞİİRLER',
      'KORKU',
      'POLİSİYE',
    ];
    String? selectedItem = 'Kitap türü seçin';
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

  dateBoxMaker(String boxOfName) {
    TextEditingController _dateController = TextEditingController();
    Future<void> _selectDate() async {
      DateTime? _picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100));
      if (_picked != null) {
        setState(() {
          _dateController.text = _picked.toString().split(" ")[0];
        });
      }
    }

    return Container(
      padding: EdgeInsets.only(bottom: 5.0, top: 10.0),
      child: TextField(
        controller: _dateController,
        decoration: InputDecoration(
            labelText: boxOfName,
            prefixIcon: Icon(Icons.calendar_today),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black))),
        readOnly: true,
        onTap: () {
          _selectDate();
        },
      ),
    );
  }
}
