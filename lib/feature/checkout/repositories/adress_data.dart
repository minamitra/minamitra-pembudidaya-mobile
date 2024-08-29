class Address {
  String title;
  String address;
  String? type;

  Address({
    required this.title,
    required this.address,
    this.type,
  });
}

List<Address> listAddress = [
  Address(
    title: "Rumah",
    address:
        "Martapura, Kabupaten Ogan Komering, Paku Sengkunyit, Kec. Martapura, Ulu Timur, Sumatera Selatan 32313",
    type: "Utama",
  ),
  Address(
    title: "Kantor",
    address:
        "Martapura, Kabupaten Ogan Komering, Paku Sengkunyit, Kec. Martapura, Ulu Timur, Sumatera Selatan 32313",
  ),
];
