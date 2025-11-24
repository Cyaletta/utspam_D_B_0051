import 'package:flutter/material.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  final Map user;
  const ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Pengguna')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _item('Nama Lengkap', user['nama']),
                    const Divider(),
                    _item('Username', user['username']),
                    const Divider(),
                    _item('Email', user['email']),
                    const Divider(),
                    _item('Nomor Telepon', user['notelp']),
                    const Divider(),
                    _item('Alamat', user['alamat']),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                    (route) => false,
                  );
                },
                child: const Text('Keluar (Logout)'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(String label, String? value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(label, style: const TextStyle(color: Colors.grey)),
        ),
        Expanded(
          child: Text(
            value ?? '-',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}