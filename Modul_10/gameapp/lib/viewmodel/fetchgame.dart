import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gameapp/model/game.dart';
import 'package:gameapp/model/detailgame.dart';

/// Ambil daftar game dari API FreeToGame
Future<List<Game>> fetchGames() async {
  final response = await http.get(Uri.parse('https://www.freetogame.com/api/games'));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    return jsonData.map((item) => Game.fromJson(item)).toList();
  } else {
    throw Exception('Gagal mengambil data game');
  }
}

/// Ambil data detail game berdasarkan ID
Future<Map<String, dynamic>> fetchDataFromAPI(int idGame) async {
  final response = await http.get(Uri.parse('https://www.freetogame.com/api/game?id=$idGame'));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    if (jsonData != null && jsonData is Map<String, dynamic>) {
      return jsonData;
    } else {
      throw Exception('Data dari API tidak sesuai dengan yang diharapkan');
    }
  } else {
    throw Exception('Gagal mengambil data dari API');
  }
}

/// Helper untuk langsung mengubah JSON menjadi objek DetailGame
Future<DetailGame> fetchDetailGame(int idGame) async {
  final jsonData = await fetchDataFromAPI(idGame);
  return DetailGame.fromJson(jsonData);
}
