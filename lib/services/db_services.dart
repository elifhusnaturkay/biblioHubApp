import 'package:mysql1/mysql1.dart';

class DB {
  MySqlConnection? _connection;

  Future<void> connect() async {
    final settings = ConnectionSettings(
      host: 'localhost',
      port: 3306, // MySQL sunucunuzun portu
      user: 'root',
      password: '',
      db: 'kutuphaneapp',
    );

    try {
      _connection = await MySqlConnection.connect(settings);
    } catch (e) {
      print('Veritabanına bağlanırken hata oluştu: $e');
      throw e;
    }
  }

  Future<int?> addBookFromUserInput({
    required String kitapTuru,
    required String kitapAdi,
    required String sayfaSayisi,
    required String kitapAciklama,
    required String yazarAdi,
    required String userId, // Kullanıcının Firebase UID'si
  }) async {
    try {
      final result = await addBook(
        kitapTuru: kitapTuru,
        kitapAdi: kitapAdi,
        sayfaSayisi: sayfaSayisi,
        kitapAciklama: kitapAciklama,
        yazarAdi: yazarAdi,
        userId: userId,
      );

      return result;
    } catch (e) {
      print('Kitap ekleme hatası: $e');
      throw e;
    }
  }

  Future<int?> addBook({
    required String kitapTuru,
    required String kitapAdi,
    required String sayfaSayisi,
    required String kitapAciklama,
    required String yazarAdi,
    required String userId,
  }) async {
    final query = '''
    INSERT INTO books (kitapTuru, kitapAdi, sayfaSayisi, kitapAciklama, yazarAdi, user_id)
    VALUES (?, ?, ?, ?, ?, ?)
  ''';

    try {
      final result = await _connection!.query(query, [
        kitapTuru,
        kitapAdi,
        sayfaSayisi,
        kitapAciklama,
        yazarAdi,
        userId,
      ]);

      return result.insertId; // Yeni eklenen kitabın kimliğini döndür
    } catch (e) {
      print('Kitap ekleme hatası: $e');
      throw e; // Hata yönetimi burada
    }
  }

  Future<void> close() async {
    if (_connection != null) {
      try {
        await _connection!.close();
      } catch (e) {
        print('Bağlantıyı kapatırken hata oluştu: $e');
        throw e;
      }
    }
  }
}
