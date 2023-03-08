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

class AddNewProject {
  final String pId;
  final String pName;
  final String pDescription;
  final String gitHubLink;
  final String userName;
  final int postLike;

  AddNewProject({
    this.postLike = 0,
    required this.pId,
    required this.pName,
    required this.pDescription,
    required this.gitHubLink,
    required this.userName,
  });

  /// This method is used to convert the json data to the AddNewProject model.
  factory AddNewProject.fromJson(Map<String, dynamic> json) {
    return AddNewProject(
      postLike: json['postLike'],
      pId: json['pId'],
      pName: json['pName'],
      pDescription: json['pDescription'],
      gitHubLink: json['gitHubLink'],
      userName: json['userName'],
    );
  }

  /// This method is used to convert the AddNewProject model to the json data.
  Map<String, dynamic> toJson() {
    return {
      'pId': pId,
      'pName': pName,
      'pDescription': pDescription,
      'gitHubLink': gitHubLink,
      'userName': userName,
      'postLike': postLike,
    };
  }
}
