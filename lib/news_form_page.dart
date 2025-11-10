import 'package:flutter/material.dart';

class NewsFormPage extends StatefulWidget {
  const NewsFormPage({super.key});

  @override
  State<NewsFormPage> createState() => _NewsFormPageState();
}

class _NewsFormPageState extends State<NewsFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();
  final _thumbController = TextEditingController();
  final _categoryController = TextEditingController();
  bool _isFeatured = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product Form"),
        backgroundColor: Colors.green[700],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green[700]),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Football Shop",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Tambah produk baru di sini!",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_box_outlined),
              title: const Text("Add Product"),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 8),
              _buildTextField(
                label: "Nama Produk",
                controller: _nameController,
                validator: (v) => v == null || v.isEmpty
                    ? "Nama produk tidak boleh kosong"
                    : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: "Harga Produk",
                controller: _priceController,
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return "Harga tidak boleh kosong";
                  final p = num.tryParse(v);
                  if (p == null) return "Harga harus berupa angka";
                  if (p < 0) return "Harga tidak boleh negatif";
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: "Deskripsi Produk",
                controller: _descController,
                maxLines: 3,
                validator: (v) =>
                    v == null || v.isEmpty ? "Deskripsi wajib diisi" : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: "URL Thumbnail",
                controller: _thumbController,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "URL thumbnail wajib diisi";
                  }
                  final uri = Uri.tryParse(v);
                  if (uri == null || !uri.hasAbsolutePath) {
                    return "URL tidak valid";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: "Kategori Produk",
                controller: _categoryController,
                validator: (v) =>
                    v == null || v.isEmpty ? "Kategori wajib diisi" : null,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Tandai sebagai Produk Unggulan"),
                  Switch(
                    value: _isFeatured,
                    onChanged: (v) => setState(() => _isFeatured = v),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Data Produk"),
                          content: Text(
                            "Nama: ${_nameController.text}\n"
                            "Harga: ${_priceController.text}\n"
                            "Deskripsi: ${_descController.text}\n"
                            "Thumbnail: ${_thumbController.text}\n"
                            "Kategori: ${_categoryController.text}\n"
                            "Unggulan: ${_isFeatured ? "Ya" : "Tidak"}",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
