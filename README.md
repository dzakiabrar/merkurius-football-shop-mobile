1. Perbedaan antara Navigator.push() dan Navigator.pushReplacement()

🔹 Navigator.push()

Digunakan untuk menambahkan halaman baru di atas stack navigasi (halaman sebelumnya tetap ada di bawah).

Ketika user menekan tombol back, aplikasi akan kembali ke halaman sebelumnya.

digunakan ketika pengguna ingin kembali ke halaman sebelumnya.

🔹 Navigator.pushReplacement()

Digunakan untuk mengganti halaman saat ini dengan halaman baru.

Halaman sebelumnya dihapus dari stack, sehingga user tidak bisa kembali ke halaman sebelumnya menggunakan tombol back.

🛍️ Dalam aplikasi Football Shop:

Gunakan Navigator.push() saat membuka halaman seperti “Tambah Produk” dari halaman utama. 
Misalnya:

Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const NewsFormPage()),
);

Navigator.pushReplacement() digunakan ketika user ingin mengganti halaman sepenuhnya, contohnya setelah pengguna logout.

2. Pemanfaatan hierarchy widget seperti Scaffold, AppBar, dan Drawer

🔹 Scaffold

Memberikan struktur dasar halaman seperti AppBar, body, dan Drawer.

Semua halaman utama di aplikasi Football Shop menggunakan Scaffold agar layout-nya konsisten.

🔹 AppBar

Menampilkan judul halaman seperti “Merkurius Football Shop” di bagian atas.

Diberi warna hijau agar seragam dengan tema brand.

🔹 Drawer

Menyediakan navigasi utama aplikasi (misalnya: “Halaman Utama” dan “Tambah Produk”).

Diletakkan di dalam Scaffold supaya bisa diakses dari setiap halaman.

Contoh penggunaan di Football Shop:

return Scaffold(
  appBar: AppBar(
    backgroundColor: Colors.green,
    title: const Text('Merkurius Football Shop'),
  ),
  drawer: Drawer(
    child: ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Halaman Utama'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.add),
          title: const Text('Tambah Produk'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NewsFormPage()),
            );
          },
        ),
      ],
    ),
  ),
  body: ...
);


3. Kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView dalam form

🔹 Padding

Menambahkan jarak agar elemen tidak terlalu mepet dengan tepi layar.

Membuat tampilan lebih rapi dan nyaman dibaca.

🔹 SingleChildScrollView

Memungkinkan halaman bisa di-scroll saat elemen form terlalu banyak.

Berguna pada layar kecil agar input tidak terpotong ketika keyboard muncul.

🔹 ListView

Mirip dengan SingleChildScrollView, tapi lebih fleksibel untuk menampilkan banyak widget secara vertikal (otomatis scrollable).

Contoh dari halaman form “Tambah Produk”:

body: SingleChildScrollView(
  padding: const EdgeInsets.all(16.0),
  child: Column(
    children: [
      TextFormField(
        decoration: const InputDecoration(labelText: 'Nama Produk'),
        validator: (value) =>
            value == null || value.isEmpty ? 'Nama tidak boleh kosong' : null,
      ),
      const SizedBox(height: 16),
      TextFormField(
        decoration: const InputDecoration(labelText: 'Harga Produk'),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) return 'Harga wajib diisi';
          if (int.tryParse(value)! < 0) return 'Harga tidak boleh negatif';
          return null;
        },
      ),
      const SizedBox(height: 16),
      TextFormField(
        decoration: const InputDecoration(labelText: 'Deskripsi Produk'),
        maxLines: 3,
      ),
    ],
  ),
),


4. Menyesuaikan warna tema agar konsisten dengan brand Football Shop

Warna utama toko adalah hijau, sehingga digunakan sebagai seed color pada ThemeData:

theme: ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
  useMaterial3: true,
),

Komponen utama seperti AppBar, tombol, dan header menggunakan warna hijau:

backgroundColor: Colors.green,


Warna teks dan ikon dibuat kontras (putih) agar mudah dibaca:

style: const TextStyle(color: Colors.white)