import 'package:flutter/material.dart';
import 'package:gameapp/viewmodel/fetchgame.dart';
import 'package:gameapp/model/detailgame.dart';
import 'package:readmore/readmore.dart';

class Detail extends StatelessWidget {
  final int gameTerpilih;
  const Detail({super.key, required this.gameTerpilih});

  Future<DetailGame> fetchData() async {
    final jsonData = await fetchDataFromAPI(gameTerpilih);
    return DetailGame.fromJson(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent.shade400,
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Data tidak tersedia'));
          } else {
            final game = snapshot.data!;
            return Column(
              children: [
                // Header dengan gambar + tombol back
                SizedBox(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                        child: Image.network(
                          game.thumbnail,
                          fit: BoxFit.cover,
                          height: 300,
                        ),
                      ),
                      Positioned(
                        top: 25,
                        left: 10,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.8),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Expanded untuk konten detail
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Minimum System Requirements
                          Container(
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'Minimum System Requirements',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                _requirementRow('OS', game.minimumSystemRequirements.os),
                                _requirementRow('Processor', game.minimumSystemRequirements.processor),
                                _requirementRow('Memory', game.minimumSystemRequirements.memory),
                                _requirementRow('Graphics', game.minimumSystemRequirements.graphics),
                                _requirementRow('Storage', game.minimumSystemRequirements.storage),
                              ],
                            ),
                          ),

                          // Screenshot horizontal
                          Container(
                            height: 200,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                for (var ss in game.screenshots) ...[
                                  _itemList(ss.image),
                                  const SizedBox(width: 15),
                                ]
                              ],
                            ),
                          ),

                          // Deskripsi dengan ReadMore
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            child: ReadMoreText(
                              game.description,
                              trimLines: 2,
                              colorClickableText: Colors.amberAccent.shade400,
                              trimMode: TrimMode.Line,
                              style: TextStyle(
                                color: Colors.black54.withOpacity(0.8),
                                height: 1.5,
                              ),
                              trimCollapsedText: 'more',
                              trimExpandedText: 'less',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

// Method tambahan di luar class
SizedBox _itemList(String url) {
  return SizedBox(
    width: 250,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(url, fit: BoxFit.cover),
    ),
  );
}

Row _requirementRow(String title, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(flex: 3, child: Text(title)),
      const Expanded(flex: 1, child: Text(':')),
      Expanded(flex: 8, child: Text(value)),
    ],
  );
}
