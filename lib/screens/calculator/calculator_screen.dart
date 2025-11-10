import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:green_sense/widgets/layout/page_scaffold.dart';
import 'package:green_sense/widgets/forms/custom_text_field.dart';
import 'package:green_sense/widgets/forms/custom_dropdown.dart';
import 'package:green_sense/widgets/forms/custom_slider.dart';
import 'package:green_sense/providers/calculator_provider.dart';
import 'package:green_sense/utils/responsive.dart';
import 'package:green_sense/constants/app_colors.dart';
import 'package:green_sense/constants/app_styles.dart';
import 'package:go_router/go_router.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  // Transportation
  final _carMilesController = TextEditingController(text: '0');
  String _fuelType = 'Gasoline';
  final _publicTransitController = TextEditingController(text: '0');
  final _flightsController = TextEditingController(text: '0');

  // Home Energy
  final _electricityController = TextEditingController(text: '0');
  final _naturalGasController = TextEditingController(text: '0');
  final _heatingFuelController = TextEditingController(text: '0');
  double _renewablePercent = 0;

  // Diet
  final _beefController = TextEditingController(text: '0');
  final _poultryController = TextEditingController(text: '0');
  final _fishController = TextEditingController(text: '0');
  double _localFoodPercent = 0;
  double _foodWastePercent = 0;

  // Waste
  double _recyclingPercent = 50;
  bool _composting = false;
  double _singleUsePlasticLevel = 50;

  @override
  void dispose() {
    _carMilesController.dispose();
    _publicTransitController.dispose();
    _flightsController.dispose();
    _electricityController.dispose();
    _naturalGasController.dispose();
    _heatingFuelController.dispose();
    _beefController.dispose();
    _poultryController.dispose();
    _fishController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Carbon Footprint Calculator',
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Responsive.isMobile(context) ? 16 : 32),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor.withOpacity(0.1),
                            AppColors.accentColor.withOpacity(0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Calculate Your Carbon Footprint',
                            style: Responsive.isMobile(context)
                                ? AppStyles.headline3
                                : AppStyles.headline2,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Answer a few questions about your lifestyle to estimate your annual carbon emissions',
                            style: AppStyles.bodyText.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Progress Indicator
                    _buildProgressIndicator(),

                    const SizedBox(height: 32),

                    // Stepper Content
                    _buildStepContent(),

                    const SizedBox(height: 32),

                    // Navigation Buttons
                    _buildNavigationButtons(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Step ${_currentStep + 1} of 4',
          style: AppStyles.bodyText.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: (_currentStep + 1) / 4,
            backgroundColor: AppColors.borderColor,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildTransportationStep();
      case 1:
        return _buildHomeEnergyStep();
      case 2:
        return _buildDietStep();
      case 3:
        return _buildWasteStep();
      default:
        return Container();
    }
  }

  Widget _buildTransportationStep() {
    return _buildStepCard(
      title: 'Transportation',
      icon: Icons.directions_car,
      children: [
        CustomTextField(
          controller: _carMilesController,
          label: 'Car Miles Per Year',
          hint: 'Enter annual miles driven',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a value';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        CustomDropdown(
          value: _fuelType,
          label: 'Vehicle Fuel Type',
          items: ['Gasoline', 'Diesel', 'Electric', 'Hybrid'],
          onChanged: (value) {
            setState(() {
              _fuelType = value!;
            });
          },
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: _publicTransitController,
          label: 'Public Transit Miles Per Year',
          hint: 'Enter annual miles on bus, train, subway',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a value';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: _flightsController,
          label: 'Number of Flights Per Year',
          hint: 'Enter number of round-trip flights',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a value';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildHomeEnergyStep() {
    return _buildStepCard(
      title: 'Home Energy',
      icon: Icons.house,
      children: [
        CustomTextField(
          controller: _electricityController,
          label: 'Monthly Electricity Usage (kWh)',
          hint: 'Check your utility bill',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a value';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: _naturalGasController,
          label: 'Monthly Natural Gas Usage (therms)',
          hint: 'Check your utility bill',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a value';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: _heatingFuelController,
          label: 'Yearly Heating Fuel (gallons)',
          hint: 'Oil, propane, etc.',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a value';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        CustomSlider(
          label: 'Renewable Energy',
          value: _renewablePercent,
          min: 0,
          max: 100,
          divisions: 20,
          valueLabel: '${_renewablePercent.round()}%',
          onChanged: (value) {
            setState(() {
              _renewablePercent = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDietStep() {
    return _buildStepCard(
      title: 'Diet',
      icon: Icons.restaurant,
      children: [
        CustomTextField(
          controller: _beefController,
          label: 'Beef Servings Per Week',
          hint: 'Number of servings',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a value';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: _poultryController,
          label: 'Poultry Servings Per Week',
          hint: 'Chicken, turkey, etc.',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a value';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: _fishController,
          label: 'Fish Servings Per Week',
          hint: 'Number of servings',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a value';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        CustomSlider(
          label: 'Local/Seasonal Food',
          value: _localFoodPercent,
          min: 0,
          max: 100,
          divisions: 20,
          valueLabel: '${_localFoodPercent.round()}%',
          onChanged: (value) {
            setState(() {
              _localFoodPercent = value;
            });
          },
        ),
        const SizedBox(height: 20),
        CustomSlider(
          label: 'Food Waste',
          value: _foodWastePercent,
          min: 0,
          max: 100,
          divisions: 20,
          valueLabel: '${_foodWastePercent.round()}%',
          onChanged: (value) {
            setState(() {
              _foodWastePercent = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildWasteStep() {
    return _buildStepCard(
      title: 'Waste & Recycling',
      icon: Icons.recycling,
      children: [
        CustomSlider(
          label: 'Recycling Rate',
          value: _recyclingPercent,
          min: 0,
          max: 100,
          divisions: 20,
          valueLabel: '${_recyclingPercent.round()}%',
          onChanged: (value) {
            setState(() {
              _recyclingPercent = value;
            });
          },
        ),
        const SizedBox(height: 20),
        CheckboxListTile(
          title: Text(
            'I compost food waste',
            style: AppStyles.bodyText,
          ),
          value: _composting,
          onChanged: (value) {
            setState(() {
              _composting = value ?? false;
            });
          },
          activeColor: AppColors.primaryColor,
          contentPadding: EdgeInsets.zero,
        ),
        const SizedBox(height: 20),
        CustomSlider(
          label: 'Single-Use Plastic Consumption',
          value: _singleUsePlasticLevel,
          min: 0,
          max: 100,
          divisions: 20,
          valueLabel: _singleUsePlasticLevel <= 25
              ? 'Low'
              : _singleUsePlasticLevel <= 75
                  ? 'Medium'
                  : 'High',
          onChanged: (value) {
            setState(() {
              _singleUsePlasticLevel = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildStepCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: AppColors.primaryColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: AppStyles.headline3,
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...children,
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (_currentStep > 0)
          OutlinedButton.icon(
            onPressed: () {
              setState(() {
                _currentStep--;
              });
            },
            icon: const Icon(Icons.arrow_back),
            label: const Text('Back'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryColor,
              side: BorderSide(color: AppColors.primaryColor),
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
            ),
          )
        else
          const SizedBox.shrink(),
        ElevatedButton.icon(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (_currentStep < 3) {
                setState(() {
                  _currentStep++;
                });
              } else {
                _calculateFootprint();
              }
            }
          },
          icon: Icon(_currentStep < 3 ? Icons.arrow_forward : Icons.calculate),
          label: Text(_currentStep < 3 ? 'Next' : 'Calculate'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  void _calculateFootprint() {
    final provider = context.read<CalculatorProvider>();

    final inputs = {
      'carMiles': double.parse(_carMilesController.text),
      'fuelType': _fuelType,
      'publicTransit': double.parse(_publicTransitController.text),
      'flights': double.parse(_flightsController.text),
      'electricity': double.parse(_electricityController.text),
      'naturalGas': double.parse(_naturalGasController.text),
      'heatingFuel': double.parse(_heatingFuelController.text),
      'renewablePercent': _renewablePercent,
      'beef': double.parse(_beefController.text),
      'poultry': double.parse(_poultryController.text),
      'fish': double.parse(_fishController.text),
      'localFood': _localFoodPercent,
      'foodWaste': _foodWastePercent,
      'recycling': _recyclingPercent,
      'composting': _composting,
      'singleUsePlastic': _singleUsePlasticLevel,
    };

    provider.calculate(inputs);
    context.go('/calculator/result');
  }
}
