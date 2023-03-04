class Explore {
  final String pName;
  final String pImage;
  final String pDescription;
  Explore({
    required this.pName,
    required this.pImage,
    required this.pDescription,
  });

  /// This method is used to convert the json data to the Explore model.
  factory Explore.fromJson(Map<String, dynamic> json) {
    return Explore(
      pName: json['pName'],
      pImage: json['pImage'],
      pDescription: json['pDescription'],
    );
  }
}
