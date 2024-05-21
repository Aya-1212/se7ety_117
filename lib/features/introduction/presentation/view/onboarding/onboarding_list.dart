class OnboardingView {
  final String svgPicture;
  final String title;
  final String description;

  OnboardingView(
      {required this.svgPicture,
      required this.title,
      required this.description});
}

List<OnboardingView> onboardingList = [
  OnboardingView(
      svgPicture: 'assets/on1.svg',
      title: 'ابحث عن دكتور متخصص',
      description:
          'اكتشف مجموعة واسعة من الأطباء الخبراء و المتخصصين في مختلف المجالات.'),
  OnboardingView(
      svgPicture: 'assets/on2on1.svg',
      title: 'سهولة الحجز',
      description: 'احجز المواعيد بضغطة زر في أي وقت وفي أي مكان.'),
  OnboardingView(
      svgPicture: 'assets/on3.svg',
      title: 'آمن و سري',
      description: 'كن مطمئنّا لأن خصوصيتك و أمانك هما أهم أولوياتنا'),
];
