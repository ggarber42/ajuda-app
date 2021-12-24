class WeatherReport {
  final String cod;
  final int cityID;
  final String name;

  WeatherReport({required this.cod, required this.cityID, required this.name});

  factory WeatherReport.fromJson(Map<String, dynamic> json) {
    return WeatherReport(
      cod: json['cod'],
      cityID: json['city']['id'],
      name: json['city']['name'],
    );
  }

  @override
  String toString() {
    return '{id: $cod, cityID: $cityID, name: $name}';
  }
}