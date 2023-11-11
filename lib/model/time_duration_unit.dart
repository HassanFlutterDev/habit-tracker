class TimeDurationUnit {
  int unit;
  String type;

  TimeDurationUnit({required this.unit, required this.type});

  String getString(){
    return "$unit $type";
  }
}
