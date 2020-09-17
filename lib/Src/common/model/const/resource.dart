class Resource {
  static const COIN = 'coin';
  static const WOOD = 'wood';
  static const STONE = 'stone';
}

class ArmyType {
  static const RIDER = 1;
  static const FIGHTER = 2;
  static const RANGE_ATTACK = 3;

  static String getName(int type) {
    switch (type) {
      case RIDER:
        {
          return 'rider';
        }
      case FIGHTER:
        {
          return 'fighter';
        }
      case RANGE_ATTACK:
        {
          return 'rangeAttack';
        }
    }
    return "";
  }
}
