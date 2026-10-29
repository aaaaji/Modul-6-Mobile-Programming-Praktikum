
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lokasi Saya',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const LocationScreen(),
    );
  }
}

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String? _kecamatan;
  String? _kota;
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _getLocation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _kecamatan = null;
      _kota = null;
    });

    try {
      // 1. Periksa apakah layanan lokasi aktif
      final bool serviceEnabled =
      await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        throw Exception(
          'Layanan lokasi tidak aktif. Mohon aktifkan GPS.',
        );
      }

      // 2. Periksa izin lokasi
      LocationPermission permission =
      await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          throw Exception('Izin lokasi ditolak oleh pengguna.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
          'Izin lokasi ditolak permanen. '
              'Silakan aktifkan izin melalui pengaturan aplikasi.',
        );
      }

      // 3. Ambil posisi perangkat
      final Position position =
      await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // 4. Ubah koordinat menjadi informasi alamat
      final List<Placemark> placemarks =
      await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isEmpty) {
        throw Exception(
          'Informasi alamat tidak ditemukan.',
        );
      }

      final Placemark place = placemarks.first;

      if (!mounted) return;

      setState(() {
        _kecamatan = place.subLocality;
        _kota = place.subAdministrativeArea;
      });

      // Jika nama wilayah kosong, tampilkan informasi cadangan
      if ((_kecamatan == null || _kecamatan!.isEmpty) &&
          (_kota == null || _kota!.isEmpty)) {
        setState(() {
          _kecamatan = 'Informasi wilayah tidak tersedia';
          _kota = 'Informasi kota tidak tersedia';
        });
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage =
            e.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lokasi Saya',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1A237E),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.location_on,
                size: 72,
                color: Color(0xFF1A237E),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: _buildLocationContent(),
                ),
              ),
              const SizedBox(height: 28),
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _getLocation,
                icon: const Icon(Icons.my_location),
                label: const Text(
                  'TAMPILKAN LOKASI SAAT INI',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A237E),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationContent() {
    if (_isLoading) {
      return const Column(
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Sedang mengambil lokasi...'),
        ],
      );
    }

    if (_errorMessage != null) {
      return Column(
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 40,
          ),
          const SizedBox(height: 12),
          Text(
            _errorMessage!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red),
          ),
        ],
      );
    }

    if (_kecamatan == null && _kota == null) {
      return const Text(
        'Tekan tombol di bawah untuk menampilkan lokasi.',
        textAlign: TextAlign.center,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informasi Lokasi',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Kelurahan/Kecamatan:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(_kecamatan ?? 'Tidak tersedia'),
        const SizedBox(height: 12),
        const Text(
          'Kota:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(_kota ?? 'Tidak tersedia'),
      ],
    );
  }
}
