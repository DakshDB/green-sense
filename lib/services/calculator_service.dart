import '../models/calculator_input.dart';
import '../models/calculator_result.dart';

class CalculatorService {
  // Emission factors (kg CO2)

  // Transportation
  static const double gasolineCarPerMile = 0.404; // kg CO2 per mile
  static const double dieselCarPerMile = 0.424;
  static const double hybridCarPerMile = 0.203;
  static const double electricCarPerMile = 0.092; // US grid average

  static const double publicTransitPerHourPerWeek = 2.6; // kg CO2 per hour per week (annual)
  static const double shortFlightAverageMiles = 1000.0; // Average short-haul flight miles
  static const double longFlightAverageMiles = 3500.0; // Average long-haul flight miles
  static const double shortFlightPerMile = 0.24; // kg CO2 per mile
  static const double longFlightPerMile = 0.18; // kg CO2 per mile (more efficient)

  // Home Energy
  static const double electricityPerKwh = 0.417; // kg CO2/kWh US average
  static const double naturalGasPerTherm = 5.3; // kg CO2/therm
  static const double heatingOilPerGallon = 10.2; // kg CO2/gallon
  static const double propanePerGallon = 5.7; // kg CO2/gallon

  // Diet (kg CO2 per kg of food)
  static const double beefPerKg = 27.0;
  static const double poultryPerKg = 6.9;
  static const double fishPerKg = 5.1;
  static const double plantBasedPerKg = 2.0;

  // Average serving size in kg
  static const double servingToKg = 0.2; // 200g

  // Waste (annual kg CO2)
  static const double wasteNeverRecycle = 500.0;
  static const double wasteSometimesRecycle = 250.0;
  static const double wasteAlwaysRecycle = 100.0;
  static const double compostingReduction = 100.0;
  static const double plasticHighUsage = 200.0;
  static const double plasticMediumUsage = 100.0;
  static const double plasticLowUsage = 30.0;

  // US average for comparison
  static const double usAverageAnnualCO2 = 16000.0; // kg (16 tons)

  /// Calculate total carbon footprint
  CalculatorResult calculate(CalculatorInput input) {
    double transportEmissions = _calculateTransport(input);
    double energyEmissions = _calculateEnergy(input);
    double dietEmissions = _calculateDiet(input);
    double wasteEmissions = _calculateWaste(input);

    double total = transportEmissions + energyEmissions + dietEmissions + wasteEmissions;

    Map<String, double> breakdown = {
      'Transportation': transportEmissions,
      'Home Energy': energyEmissions,
      'Diet': dietEmissions,
      'Waste': wasteEmissions,
    };

    return CalculatorResult(
      totalCO2: total,
      breakdown: breakdown,
      recommendations: _generateRecommendations(input, breakdown),
    );
  }

  /// Calculate transportation emissions
  double _calculateTransport(CalculatorInput input) {
    double carEmissions = 0;

    // Car emissions based on fuel type
    switch (input.fuelType) {
      case 'gasoline':
        carEmissions = input.carMilesPerYear * gasolineCarPerMile;
        break;
      case 'diesel':
        carEmissions = input.carMilesPerYear * dieselCarPerMile;
        break;
      case 'hybrid':
        carEmissions = input.carMilesPerYear * hybridCarPerMile;
        break;
      case 'electric':
        carEmissions = input.carMilesPerYear * electricCarPerMile;
        break;
    }

    // Public transit (much lower per mile, but calculate based on hours)
    double publicTransitEmissions = input.publicTransitHoursPerWeek * publicTransitPerHourPerWeek;

    // Flight emissions
    double flightEmissions =
      (input.shortHaulFlightsPerYear * shortFlightAverageMiles * shortFlightPerMile) +
      (input.longHaulFlightsPerYear * longFlightAverageMiles * longFlightPerMile);

    return carEmissions + publicTransitEmissions + flightEmissions;
  }

  /// Calculate home energy emissions
  double _calculateEnergy(CalculatorInput input) {
    // Electricity (annual)
    double electricityAnnual = input.electricityKwhPerMonth * 12;
    double electricityEmissions = electricityAnnual * electricityPerKwh;

    // Adjust for renewable energy percentage
    electricityEmissions *= (100 - input.renewableEnergyPercentage) / 100;

    // Natural gas (annual)
    double naturalGasAnnual = input.naturalGasThermsPerMonth * 12;
    double naturalGasEmissions = 0;

    // Heating fuel emissions
    switch (input.heatingFuelType) {
      case 'natural_gas':
        naturalGasEmissions = naturalGasAnnual * naturalGasPerTherm;
        break;
      case 'oil':
        // Assuming therms converted to gallons (1 therm ≈ 0.7 gallons)
        naturalGasEmissions = naturalGasAnnual * 0.7 * heatingOilPerGallon;
        break;
      case 'propane':
        naturalGasEmissions = naturalGasAnnual * 0.9 * propanePerGallon;
        break;
      case 'electric':
        // Already counted in electricity
        break;
    }

    return electricityEmissions + naturalGasEmissions;
  }

  /// Calculate diet emissions
  double _calculateDiet(CalculatorInput input) {
    // Calculate annual emissions from different foods
    double beefEmissions = input.beefServingsPerWeek * 52 * servingToKg * beefPerKg;
    double poultryEmissions = input.poultryServingsPerWeek * 52 * servingToKg * poultryPerKg;
    double fishEmissions = input.fishServingsPerWeek * 52 * servingToKg * fishPerKg;

    // Total before adjustments
    double totalDiet = beefEmissions + poultryEmissions + fishEmissions;

    // Adjust for local food (reduces transportation emissions by percentage)
    double localFoodReduction = totalDiet * (input.localFoodPercentage / 100) * 0.1;

    // Adjust for food waste (wasted food still has footprint)
    double wasteIncrease = totalDiet * (input.foodWastePercentage / 100);

    return totalDiet - localFoodReduction + wasteIncrease;
  }

  /// Calculate waste emissions
  double _calculateWaste(CalculatorInput input) {
    double recyclingEmissions = 0;

    // Recycling impact
    switch (input.recyclingFrequency) {
      case 'never':
        recyclingEmissions = wasteNeverRecycle;
        break;
      case 'sometimes':
        recyclingEmissions = wasteSometimesRecycle;
        break;
      case 'always':
        recyclingEmissions = wasteAlwaysRecycle;
        break;
    }

    // Composting reduces methane from landfills
    if (input.composting) {
      recyclingEmissions -= compostingReduction;
    }

    // Plastic usage
    double plasticEmissions = 0;
    switch (input.singleUsePlasticUsage) {
      case 'high':
        plasticEmissions = plasticHighUsage;
        break;
      case 'medium':
        plasticEmissions = plasticMediumUsage;
        break;
      case 'low':
        plasticEmissions = plasticLowUsage;
        break;
    }

    return recyclingEmissions + plasticEmissions;
  }

  /// Generate top 3 personalized recommendations
  List<String> _generateRecommendations(CalculatorInput input, Map<String, double> breakdown) {
    List<MapEntry<String, double>> sorted = breakdown.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    List<String> recommendations = [];

    for (var entry in sorted.take(3)) {
      switch (entry.key) {
        case 'Transportation':
          if (input.carMilesPerYear > 10000) {
            recommendations.add(
              'Transportation is your highest impact category. Try carpooling, public transit, biking for short trips, or consider an electric/hybrid vehicle. Reducing car miles by 25% would save ${(entry.value * 0.25).toStringAsFixed(0)} kg CO2 annually.');
          } else if (input.shortHaulFlightsPerYear > 2 || input.longHaulFlightsPerYear > 1) {
            recommendations.add(
              'Air travel is a major contributor. Each flight has a huge footprint. Consider video calls instead of business travel, or choose closer vacation destinations. Reducing flights could save hundreds of kg CO2.');
          } else {
            recommendations.add(
              'Your transportation emissions are relatively low. Keep it up! Walking, biking, and public transit are excellent choices.');
          }
          break;
        case 'Home Energy':
          if (input.electricityKwhPerMonth > 900) {
            recommendations.add(
              'Home energy is a major contributor. Switch to LED bulbs, unplug devices, improve insulation, use a programmable thermostat. Reducing electricity by 20% could save ${(entry.value * 0.2).toStringAsFixed(0)} kg CO2 annually.');
          } else if (input.renewableEnergyPercentage < 50) {
            recommendations.add(
              'Consider switching to renewable energy from your utility or installing solar panels. This could cut your energy emissions dramatically.');
          } else {
            recommendations.add(
              'Your energy usage is relatively efficient. Continue with energy-saving practices and consider increasing renewable energy percentage.');
          }
          break;
        case 'Diet':
          if (input.beefServingsPerWeek > 3) {
            recommendations.add(
              'Beef has the highest food carbon footprint. Reducing beef by half would save ${(input.beefServingsPerWeek * 26 * servingToKg * beefPerKg * 0.5).toStringAsFixed(0)} kg CO2 annually. Try Meatless Monday or substitute chicken, fish, or plant proteins.');
          } else if (input.foodWastePercentage > 25) {
            recommendations.add(
              'Food waste is significant. Plan meals better, store food properly, eat leftovers, and compost. Reducing waste by half saves emissions and money.');
          } else {
            recommendations.add(
              'Your diet footprint is moderate. Consider eating more local, seasonal produce and continuing to minimize food waste.');
          }
          break;
        case 'Waste':
          if (input.recyclingFrequency != 'always') {
            recommendations.add(
              'Improve recycling habits - always recycle properly could save ${(wasteNeverRecycle - wasteAlwaysRecycle).toStringAsFixed(0)} kg CO2 annually. Learn your local recycling rules.');
          }
          if (!input.composting) {
            recommendations.add(
              'Start composting food scraps to reduce methane from landfills and create nutrient-rich soil. Could save ${compostingReduction.toStringAsFixed(0)} kg CO2 annually.');
          }
          if (input.singleUsePlasticUsage == 'high') {
            recommendations.add(
              'Reduce single-use plastics dramatically. Bring reusable bags, bottles, containers. Switching from high to low plastic use saves ${(plasticHighUsage - plasticLowUsage).toStringAsFixed(0)} kg CO2 annually.');
          }
          if (recommendations.isEmpty) {
            recommendations.add(
              'Your waste management is good! Continue recycling, composting, and avoiding single-use plastics.');
          }
          break;
      }
    }

    return recommendations.take(3).toList();
  }

  /// Compare to US average
  double compareToAverage(double totalCO2) {
    return ((totalCO2 - usAverageAnnualCO2) / usAverageAnnualCO2) * 100;
  }
}
