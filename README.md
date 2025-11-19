Mengapa perlu membuat model Dart untuk data JSON?
Karena kalau langsung pakai Map<String, dynamic>, kita kehilangan type safety, null safety, dan autocompletion di IDE. Akibatnya:

Rawan error saat runtime (misal salah akses key, atau nilai ternyata null)
Harus null-check manual di mana-mana
Sulit maintain dan refactor kalau backend ubah nama field
Tidak ada bantuan dari Dart analyzer

Dengan model Dart (class + fromJson/toJson), kode jadi aman, rapi, mudah dibaca, dan otomatis ikut perubahan struktur JSON.
Fungsi package http dan CookieRequest

http: cuma buat kirim request biasa (GET, POST, dll.), tapi tidak menyimpan cookie session secara otomatis.
CookieRequest (dari package pbp_django_auth): wrapper dari http yang otomatis menyimpan dan mengirim cookie sessionid + csrftoken ke Django setiap kali request.

Jadi setelah login, semua request harus pakai CookieRequest supaya Django tahu kita sudah login.
Mengapa CookieRequest harus dibagikan ke seluruh aplikasi?
Karena session Django disimpan di cookie. Kalau tiap halaman bikin instance CookieRequest baru, cookie-nya hilang → Django anggap kita belum login → selalu kena redirect atau 403. Makanya kita pakai Provider supaya satu instance CookieRequest dipakai bersama di seluruh aplikasi.
Konfigurasi agar Flutter bisa connect ke Django

Django ALLOWED_HOSTS harus ditambah '10.0.2.2' (IP khusus emulator Android ke host komputer)
Pasang django-cors-headers biar browser tidak blokir request dari Flutter web/mobile
Set SameSite=None dan Secure=true untuk cookie (khusus produksi/HTTPS)
Tambah izin internet di AndroidManifest.xml

Kalau salah satu tidak diatur, hasilnya: tidak bisa login, tidak bisa ambil data, atau muncul error CORS / DisallowedHost.
Alur pengiriman data dari form Flutter sampai muncul di aplikasi

User isi form → data masuk ke controller/state
Tekan submit → data diubah jadi object Dart → di-convert ke JSON lewat toJson()
Kirim pakai request.postJson() (otomatis bawa cookie session)
Django terima → validasi → simpan ke database → kembalikan response JSON
Flutter baca response → kalau sukses, refresh list / kembali ke halaman sebelumnya

Mekanisme autentikasi (login, register, logout)

Register: Flutter kirim username + password → Django buat user → langsung login otomatis → kirim cookie sessionid
Login: Flutter kirim username + password → Django cek dengan authenticate() → kalau benar, panggil login() → buat session → kirim cookie sessionid
Setelah login: semua request berikutnya otomatis bawa cookie → Django tahu user siapa lewat request.user
Logout: Flutter panggil endpoint logout → Django hapus session di server dan cookie di client → kembali ke halaman login