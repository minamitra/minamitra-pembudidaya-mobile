extension GetHourTime on String {
  int getHourTime() {
    switch (toLowerCase()) {
      case "pagi":
        return 7;
      case "siang":
        return 12;
      case "sore":
        return 16;
      case "malam":
        return 20;
      default:
        return 7;
    }
  }
}
