class CalculatorResult {
  final double totalCO2; // in kg per year
  final Map<String, double> breakdown; // category -> kg CO2
  final List<String> recommendations;

  CalculatorResult({
    required this.totalCO2,
    required this.breakdown,
    required this.recommendations,
  });

  double get totalCO2Tons => totalCO2 / 1000;

  Map<String, dynamic> toJson() => {
        'totalCO2': totalCO2,
        'breakdown': breakdown,
        'recommendations': recommendations,
      };

  factory CalculatorResult.fromJson(Map<String, dynamic> json) =>
      CalculatorResult(
        totalCO2: json['totalCO2'].toDouble(),
        breakdown: Map<String, double>.from(json['breakdown']),
        recommendations: List<String>.from(json['recommendations']),
      );
}
