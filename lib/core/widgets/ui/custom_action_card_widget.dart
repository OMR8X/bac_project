import 'package:flutter/material.dart';

class CustomActionCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String firstButtonText;
  final String secondButtonText;
  final VoidCallback onFirstPressed;
  final VoidCallback onSecondPressed;

  final Color cardColor;
  final Color titleColor;
  final Color subtitleColor;
  final double titleFontSize;
  final double subtitleFontSize;

  final Color firstButtonColor;
  final Color secondButtonColor;
  final Color firstButtonTextColor;
  final Color secondButtonTextColor;
  final BorderRadius borderRadius;
  final double borderWidth;
  final Color borderColor;

  const CustomActionCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.firstButtonText,
    required this.secondButtonText,
    required this.onFirstPressed,
    required this.onSecondPressed,
    this.cardColor = const Color(0xffF5F5F5),
    this.titleColor = Colors.black,
    this.subtitleColor = const Color(0xff666666),
    this.titleFontSize = 18,
    this.subtitleFontSize = 14,
    this.firstButtonColor = const Color(0xff3D3D3D),
    this.secondButtonColor = const Color(0xffF5F5F5),
    this.firstButtonTextColor = const Color(0xffF5F5F5),
    this.secondButtonTextColor = const Color(0xff3D3D3D),
    this.borderRadius = const BorderRadius.all(Radius.circular(7)),
    this.borderWidth = 1,
    this.borderColor = const Color(0xff3D3D3D),
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        color: cardColor,
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: subtitleFontSize,
                  color: subtitleColor,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onFirstPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: firstButtonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: borderRadius,
                          side: BorderSide(
                            color: borderColor,
                            width: borderWidth,
                          ),
                        ),
                      ),
                      child: Text(
                        firstButtonText,
                        style: TextStyle(color: firstButtonTextColor),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onSecondPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondButtonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: borderRadius,
                          side: BorderSide(
                            color: borderColor,
                            width: borderWidth,
                          ),
                        ),
                      ),
                      child: Text(
                        secondButtonText,
                        style: TextStyle(color: secondButtonTextColor),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// Try it =>
/* CustomActionCardWidget(
  title: 'العصبية',
  subtitle: "الوصف",
  firstButtonText: 'بدء الإختبار الكامل',
  secondButtonText: 'استكشاف الدروس',
  onFirstPressed: () {
    print("");
  },
  onSecondPressed: () {
    print("");
  },
  cardColor: Color(0xffF5F5F5),
  titleColor: Colors.black,
  subtitleColor: Colors.grey,
  titleFontSize: 18,
  subtitleFontSize: 14,
  firstButtonColor: Color(0xff3D3D3D),
  firstButtonTextColor: Color(0xffF5F5F5),
  secondButtonColor: Color(0xffF5F5F5),
  secondButtonTextColor: Color(0xff3D3D3D),
  borderRadius: BorderRadius.circular(7),
  borderColor: Color(0xff3D3D3D),
  borderWidth: 1,
), */