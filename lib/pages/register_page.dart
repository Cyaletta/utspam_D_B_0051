import 'package:flutter/material.dart';
import '../services/local_storage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  void submit() async {
    if (nameCtrl.text.isEmpty ||
        emailCtrl.text.isEmpty ||
        phoneCtrl.text.isEmpty ||
        addressCtrl.text.isEmpty ||
        usernameCtrl.text.isEmpty ||
        passwordCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua kolom wajib diisi')),
      );
      return;
    }

    if (!emailCtrl.text.contains('@gmail.com')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Format email tidak valid')),
      );
      return;
    }

    if (passwordCtrl.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password minimal 6 karakter')),
      );
      return;
    }

    final data = {
      'nama': nameCtrl.text,
      'email': emailCtrl.text,
      'notelp': phoneCtrl.text,
      'alamat': addressCtrl.text,
      'username': usernameCtrl.text,
      'password': passwordCtrl.text,
    };

    try {
      await DBHelper().registerUser(data);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registrasi berhasil, silakan login')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mendaftar: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrasi Pengguna Baru')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl, 
              decoration: const InputDecoration(labelText: 'Nama Lengkap', border: OutlineInputBorder())
            ),
            const SizedBox(height: 12),

            TextField(
              controller: emailCtrl, 
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder())
            ),
            const SizedBox(height: 12),
            
            TextField(
              controller: phoneCtrl, 
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Nomor Telepon', border: OutlineInputBorder())
            ),
            const SizedBox(height: 12),
            
            TextField(
              controller: addressCtrl, 
              decoration: const InputDecoration(labelText: 'Alamat', border: OutlineInputBorder())
            ),
            const SizedBox(height: 12),
            
            TextField(
              controller: usernameCtrl, 
              decoration: const InputDecoration(labelText: 'Username', border: OutlineInputBorder())
            ),
            const SizedBox(height: 12),
            
            TextField(
              controller: passwordCtrl, 
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder())
            ),
            const SizedBox(height: 20),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: submit, 
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text('Daftar Akun', style: TextStyle(fontSize: 16)),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}