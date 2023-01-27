class FGameObject extends FBox {
  final int L=-1;
  final int R=1;

  FGameObject() {
    super(gridSize, gridSize);
  }

  void act() {
  }

  boolean isTouching(String n) {
    ArrayList<FContact> spikecontacts = getContacts();
    for (int i = 0; i < spikecontacts.size(); i++) {
      FContact sc = spikecontacts.get(i);
      if (sc.contains(n)) {
        return true;
      }
    }
    return false;
  }
}
