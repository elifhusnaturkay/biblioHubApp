import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kutuphaneapp/pages/login_page.dart';
import 'package:kutuphaneapp/services/db_services.dart';

class AddBook extends StatefulWidget {
  const AddBook({Key? key}) : super(key: key);

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  TextEditingController kitapTuruController = TextEditingController();
  MaterialStatesController? kitapFotoController = MaterialStatesController();
  TextEditingController kitapAdiController = TextEditingController();
  TextEditingController kitapAciklamaController = TextEditingController();
  TextEditingController sayfaSayisiController = TextEditingController();
  TextEditingController yazarAdiController = TextEditingController();
  Uint8List? _image;
  File? selectedIMage;
  Future<void> uploadAndSaveImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final File imageFile = File(pickedImage.path);

      try {
        final imageUrl = await uploadImageToFirebaseStorage(imageFile);

        if (imageUrl != null) {
          // Görsel başarıyla yüklendi, kullanıcıya bildirim gösterin veya işlemi tamamlayın.
          print('Görsel başarıyla yüklendi. URL: $imageUrl');
          // İlerleme çubuğu veya başka bir bildirim mekanizması ekleyebilirsiniz.
        } else {
          // URL alınamadı, kullanıcıya hata mesajı gösterin.
          print('Görsel yükleme hatası: URL alınamadı.');
          // Hata mesajını göstermek için bir snackbar veya alert dialog kullanabilirsiniz.
        }
      } catch (e) {
        // Görsel yükleme hatası, kullanıcıya hata mesajı gösterin.
        print('Görsel yükleme hatası: $e');
        // Hata mesajını göstermek için bir snackbar veya alert dialog kullanabilirsiniz.
      }
    }
  }

  Future<String?> uploadImageToFirebaseStorage(File imageFile) async {
    try {
      final firebase_storage.Reference storageReference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('images')
          .child('image_${DateTime.now().millisecondsSinceEpoch}.jpg');

      final firebase_storage.UploadTask uploadTask =
          storageReference.putFile(imageFile);

      await uploadTask.whenComplete(() => null);

      final String imageUrl = await storageReference.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Görsel yükleme hatası: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
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
          color: const Color(0xF9F8F5),
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
                  InkWell(
                    statesController: kitapFotoController,
                    onTap: () {
                      showImagePickerOption(context);
                    },
                    child: Card(
                      shape: const OutlineInputBorder(
                        borderSide: BorderSide(width: 0.4),
                      ),
                      color: const Color.fromARGB(255, 249, 248, 245),
                      child: selectedIMage != null
                          ? Image.file(
                              selectedIMage!,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            )
                          : Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.add,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text("Kitap Fotoğrafı"),
                              ],
                            ),
                    ),
                  ),
                  customTextFormFieldMaker("Kitap Adı", kitapAdiController),
                  customTextFormFieldMaker(
                      "Sayfa Sayısı", sayfaSayisiController),
                  customTextFormFieldMaker(
                      "Kitap Açıklaması", kitapAciklamaController),
                  customTextFormFieldMaker("Yazar Adı", yazarAdiController),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: 180,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 179, 179, 68),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () async {
                        // Kullanıcı tarafından girilen verileri alın
                        final kitapTuru = kitapTuruController.text;
                        final kitapAdi = kitapAdiController.text;
                        final sayfaSayisi = sayfaSayisiController.text;
                        final kitapAciklama = kitapAciklamaController.text;
                        final yazarAdi = yazarAdiController.text;

                        // Kullanıcının Firebase UID'sini alın (örneğin: burada kullanıcı girişi yapılacak)
                        final userId = 'KULLANICININ_UID_SI';

                        // Görseli Firebase Storage'a yükle
                        final imageUrl =
                            await uploadImageToFirebaseStorage(selectedIMage!);

                        // DB sınıfına verileri ileterek kitap eklemesini yapın
                        final db = DB(); // DB sınıfının bir örneğini oluşturun
                        await db.connect(); // Veritabanı bağlantısını başlatın
                        final kitapId = await db.addBookFromUserInput(
                          kitapTuru: kitapTuru,
                          kitapAdi: kitapAdi,
                          sayfaSayisi: sayfaSayisi,
                          kitapAciklama: kitapAciklama,
                          yazarAdi: yazarAdi,
                          userId: userId,
                        );
                        await db.close(); // Veritabanı bağlantısını kapatın

                        if (kitapId != null) {
                          print('Yeni eklenen kitabın kimliği: $kitapId');
                          // Kullanıcıya başarı mesajı gösterin.
                          // Örneğin: ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Kitap başarıyla eklendi')));
                        } else {
                          print('Kitap eklenirken bir hata oluştu.');
                          // Kullanıcıya hata mesajı gösterin.
                          // Örneğin: ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Kitap eklenirken bir hata oluştu')));
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPageScreen(),
                          ),
                        );
                      },
                      child: const Text("Kitap Ekle"),
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

  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop(); //close the model sheet
  }

  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.blue[100],
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4.5,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImageFromGallery().then((value) {
                        if (value == null) {
                          // Kullanıcı galeriden herhangi bir görsel seçmedi.
                          // Burada bir işlem yapabilirsiniz.
                        }
                      });
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.image,
                            size: 70,
                          ),
                          Text("Gallery")
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImageFromCamera().then((value) {
                        if (value == null) {
                          // Kullanıcı kameradan herhangi bir görsel çekmedi.
                          // Burada bir işlem yapabilirsiniz.
                        }
                      });
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 70,
                          ),
                          Text("Camera")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget customTextFormFieldMaker(
    String hintText,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
        ),
      ),
    );
  }

  Widget dropDownBoxMaker(String hintText) {
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
      padding: const EdgeInsets.only(top: 10.0, bottom: 5),
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
