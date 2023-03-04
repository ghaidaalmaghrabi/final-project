class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Teams Maker",
    image: "/Users/rahaf/Desktop/flutter-2/teams_maker_rahaf_copy/assets/images/team.png",
    desc: "An app to generate team groups based on a list of members and their preferences.",
  ),
  OnboardingContents(
    title: "Hadi Albinsaad",
    image: "/Users/rahaf/Desktop/flutter-2/teams_maker_rahaf_copy/assets/images/hh.jpg",
    desc: "The leader who took the first step, The owner and developer of the idea.",
  ),
  OnboardingContents(
    title: "Rahaf Alharbi",
    image: "/Users/rahaf/Desktop/flutter-2/teams_maker_rahaf_copy/assets/images/Rahaf.png",
    desc: "The legend who made the design of the app.",
  ),
];
