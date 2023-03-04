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
    title: 'Teams Maker',
    image: '/Users/mustafa/Desktop/tuwaiq-flutter/Our-Final-Project/final-project/assets/images/codetech-logo.png',
    desc: 'An app to generate team groups based on a list of members and their preferences.',
  ),
  OnboardingContents(
    title: 'Hadi Albinsaad',
    image: '/Users/mustafa/Desktop/tuwaiq-flutter/Our-Final-Project/final-project/assets/images/codetech-logo.png',
    desc: 'The leader who took the first step, The owner and developer of the idea.',
  ),
  OnboardingContents(
    title: 'Rahaf Alharbi',
    image: '/Users/mustafa/Desktop/tuwaiq-flutter/Our-Final-Project/final-project/assets/images/codetech-logo.png',
    desc: 'The legend who made the design of the app.',
  ),
];
