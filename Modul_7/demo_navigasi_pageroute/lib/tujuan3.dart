import 'package:flutter/material.dart';

class TujuanPage3 extends StatelessWidget {
  const TujuanPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange, // latar belakang oranye
      appBar: AppBar(
        title: const Text("Halaman Tujuan"),
        backgroundColor: Colors.orange.shade700,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Ini Halaman Tujuan",
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
                "Untuk berpindah ke halaman baru, gunakan Navigator.push().\n\n"
                    "Untuk kembali ke halaman sebelumnya, gunakan Navigator.pop().",
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            // Ganti icon dengan gambar dari assets
            Image.asset(
                'assets/icon/Tujuan.png',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("< Kembali ke Home"),
            ),
          ],
        ),
      ),
    );
  }
}
