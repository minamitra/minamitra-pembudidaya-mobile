String convertGenderName(String value) {
  switch (value) {
    case "man":
      return "Laki-laki";
    case "woman":
      return "Perempuan";
    default:
      return "-";
  }
}

class GenderData {
  final String value;
  final String name;

  GenderData({
    required this.value,
    required this.name,
  });
}

List<GenderData> listGender = [
  GenderData(value: "man", name: "Laki-laki"),
  GenderData(value: "woman", name: "Perempuan"),
];
