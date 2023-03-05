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

class UserInformation {
  final String phoneNumber;
  final String gitHubLink;
  final String linkedInLink;

  UserInformation({
    required this.phoneNumber,
    required this.gitHubLink,
    required this.linkedInLink,
  });

  /// This method is used to convert the json data to the UserInformation model.
  factory UserInformation.fromJson(Map<String, dynamic> json) {
    return UserInformation(
      phoneNumber: json['phoneNumber'],
      gitHubLink: json['gitHubLink'],
      linkedInLink: json['linkedInLink'],
    );
  }

  /// This method is used to convert the UserInformation model to the json data.
  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'gitHubLink': gitHubLink,
      'linkedInLink': linkedInLink,
    };
  }
}
