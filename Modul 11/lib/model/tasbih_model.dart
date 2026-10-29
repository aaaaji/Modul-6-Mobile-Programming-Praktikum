class TasbihModel {
  final int counter;
  final double progress;

  TasbihModel({
    required this.counter,
    required this.progress,
  });

  // Method untuk reset ke kondisi awal
  factory TasbihModel.initial() {
    return TasbihModel(counter: 0, progress: 0.0);
  }

  // Method untuk copy dengan nilai baru
  TasbihModel copyWith({int? counter, double? progress}) {
    return TasbihModel(
      counter: counter ?? this.counter,
      progress: progress ?? this.progress,
    );
  }
}
