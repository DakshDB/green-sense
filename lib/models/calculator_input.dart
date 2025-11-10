class CalculatorInput {
  // Transportation
  final double carMilesPerYear;
  final String fuelType; // gasoline, diesel, hybrid, electric
  final double publicTransitHoursPerWeek;
  final int shortHaulFlightsPerYear;
  final int longHaulFlightsPerYear;

  // Home Energy
  final double electricityKwhPerMonth;
  final double naturalGasThermsPerMonth;
  final String heatingFuelType; // electric, natural_gas, oil, propane
  final double renewableEnergyPercentage; // 0-100

  // Diet
  final double beefServingsPerWeek;
  final double poultryServingsPerWeek;
  final double fishServingsPerWeek;
  final double localFoodPercentage; // 0-100
  final double foodWastePercentage; // 0-100

  // Waste
  final String recyclingFrequency; // never, sometimes, always
  final bool composting;
  final String singleUsePlasticUsage; // high, medium, low

  CalculatorInput({
    this.carMilesPerYear = 0,
    this.fuelType = 'gasoline',
    this.publicTransitHoursPerWeek = 0,
    this.shortHaulFlightsPerYear = 0,
    this.longHaulFlightsPerYear = 0,
    this.electricityKwhPerMonth = 0,
    this.naturalGasThermsPerMonth = 0,
    this.heatingFuelType = 'natural_gas',
    this.renewableEnergyPercentage = 0,
    this.beefServingsPerWeek = 0,
    this.poultryServingsPerWeek = 0,
    this.fishServingsPerWeek = 0,
    this.localFoodPercentage = 0,
    this.foodWastePercentage = 0,
    this.recyclingFrequency = 'sometimes',
    this.composting = false,
    this.singleUsePlasticUsage = 'medium',
  });

  CalculatorInput copyWith({
    double? carMilesPerYear,
    String? fuelType,
    double? publicTransitHoursPerWeek,
    int? shortHaulFlightsPerYear,
    int? longHaulFlightsPerYear,
    double? electricityKwhPerMonth,
    double? naturalGasThermsPerMonth,
    String? heatingFuelType,
    double? renewableEnergyPercentage,
    double? beefServingsPerWeek,
    double? poultryServingsPerWeek,
    double? fishServingsPerWeek,
    double? localFoodPercentage,
    double? foodWastePercentage,
    String? recyclingFrequency,
    bool? composting,
    String? singleUsePlasticUsage,
  }) {
    return CalculatorInput(
      carMilesPerYear: carMilesPerYear ?? this.carMilesPerYear,
      fuelType: fuelType ?? this.fuelType,
      publicTransitHoursPerWeek:
          publicTransitHoursPerWeek ?? this.publicTransitHoursPerWeek,
      shortHaulFlightsPerYear:
          shortHaulFlightsPerYear ?? this.shortHaulFlightsPerYear,
      longHaulFlightsPerYear:
          longHaulFlightsPerYear ?? this.longHaulFlightsPerYear,
      electricityKwhPerMonth:
          electricityKwhPerMonth ?? this.electricityKwhPerMonth,
      naturalGasThermsPerMonth:
          naturalGasThermsPerMonth ?? this.naturalGasThermsPerMonth,
      heatingFuelType: heatingFuelType ?? this.heatingFuelType,
      renewableEnergyPercentage:
          renewableEnergyPercentage ?? this.renewableEnergyPercentage,
      beefServingsPerWeek: beefServingsPerWeek ?? this.beefServingsPerWeek,
      poultryServingsPerWeek:
          poultryServingsPerWeek ?? this.poultryServingsPerWeek,
      fishServingsPerWeek: fishServingsPerWeek ?? this.fishServingsPerWeek,
      localFoodPercentage: localFoodPercentage ?? this.localFoodPercentage,
      foodWastePercentage: foodWastePercentage ?? this.foodWastePercentage,
      recyclingFrequency: recyclingFrequency ?? this.recyclingFrequency,
      composting: composting ?? this.composting,
      singleUsePlasticUsage:
          singleUsePlasticUsage ?? this.singleUsePlasticUsage,
    );
  }
}
