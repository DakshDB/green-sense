enum Category {
  climate,
  pollution,
  energy,
  water,
  waste,
  food,
  transport,
  community;

  String get displayName {
    switch (this) {
      case Category.climate:
        return 'Climate';
      case Category.pollution:
        return 'Pollution';
      case Category.energy:
        return 'Energy';
      case Category.water:
        return 'Water';
      case Category.waste:
        return 'Waste';
      case Category.food:
        return 'Food';
      case Category.transport:
        return 'Transport';
      case Category.community:
        return 'Community';
    }
  }
}
