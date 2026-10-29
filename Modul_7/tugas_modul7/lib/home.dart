import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // latar belakang biru
      appBar: AppBar(
        title: const Text("Halaman Home"),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Ini Halaman Home",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Banyak aplikasi memiliki beberapa layar untuk menampilkan informasi yang berbeda.\n\n"
                    "Gunakan Navigator.push() untuk berpindah ke halaman tujuan, dan Navigator.pop() untuk kembali.",
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white, // background putih
                shape: BoxShape.rectangle, // bentuk lingkaran
              ),
              child: Image.asset(
                'assets/icon/home.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/tujuan');
              },
              child: const Text("Ke Halaman Tujuan >"),
            ),
          ],
        ),
      ),
    );
  }
}
