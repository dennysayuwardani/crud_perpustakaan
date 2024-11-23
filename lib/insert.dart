import 'package:crud_perpustakaan/home_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  //Inisialisasi untuk mengambil data yang dimasukkan oleh pengguna
  final _formKey = GlobalKey<FormState>(); //_formKey adalah alat untuk memeriksa dan mengelola form, digunakan untuk id / primary key
  final TextEditingController _titleController = TextEditingController(); //final digunakan untuk menyatakan bahwa variabel tidak dapat diubah
  final TextEditingController _authorController = TextEditingController(); //TextEditingController  digunakan untuk mengontrol atau mengambil nilai input teks dari sebuah TextField.
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _addBook() async { //_addBook adalah fungsi untuk menambahkan buku
  // Validasi form
    if (!_formKey.currentState!.validate()) {
      return; // Jika form tidak valid, hentikan eksekusi fungsi
    }

    // Ambil nilai dari controller
    final title = _titleController.text;
    final author = _authorController.text;
    final description = _descriptionController.text;

    // Mengirim data ke tabel 'books' di Supabase
    final response = await Supabase.instance.client.from('books').insert({
      'title': title,
      'author': author,
      'description': description,
    }).select();
    if (response != null) {
      // Menampilkan pesan sukses jika berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Book added successfully!')),
      );
    
      // Mengosongkan field form
      _titleController.clear();
      _authorController.clear();
      _descriptionController.clear();

      // Kembali ke halaman utama, dan kirimkan status true
      Navigator.pop(context, true);

      //Refresh data buku
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const BookListPage()));
    } else {
      // Menampilkan pesan kesalahan jika gagal
      ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('Error: ${response}')),
      );
    }
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: UnderlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _authorController,
                decoration: const InputDecoration(
                  labelText: 'Author',
                  border: UnderlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the author';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: UnderlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: _addBook,
                  child: const Text('Add Book'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
