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

final List<OnboardingContents> contents = [
  OnboardingContents(
    title: 'كُود تِك',
    image: '/Users/rahaf/final-project/assets/images/codetech-logo.png',
    desc: 'منصة بـ هوية عربية مختصة بعرض المشاريع البرمجيّة',
  ),
  OnboardingContents(
    title: 'كُود تِك',
    image: '/Users/rahaf/final-project/assets/images/codetech-logo.png',
    desc:
        ' تُمكنك من مشاركة و عرض مشروعك كـ فيديو لاااااااا لازم نكتب شي صاحي ',
  ),
  OnboardingContents(
    title: 'كُود تِك',
    image: '/Users/rahaf/final-project/assets/images/codetech-logo.png',
    desc:
        'قُم بالتسجيل و عرض مشاريعك، او تابع كـ زائر و تصفّح المشاريع البرمجيّة ',
  ),
];
