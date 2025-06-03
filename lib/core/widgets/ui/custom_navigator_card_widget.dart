import 'package:flutter/material.dart';

class CustomNavigatorCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color cardColor;
  final Color titleColor;
  final Color subtitleColor;
  final double titleFontSize;
  final double subtitleFontSize;
  final VoidCallback onTap;
  final BorderRadius borderRadius;
  final double borderWidth;
  final Color borderColor;

  const CustomNavigatorCardWidget({
    super.key,
    required this.title,
    required this.subtitle,

    this.cardColor = const Color(0xffF5F5F5),
    this.titleColor = Colors.black,
    this.subtitleColor = const Color(0xff666666),
    this.titleFontSize = 18,
    this.subtitleFontSize = 14,
    this.borderRadius = const BorderRadius.all(Radius.circular(7)),
    this.borderWidth = 1,
    this.borderColor = const Color(0xff3D3D3D),
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Card(
          color: cardColor,
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Column(
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
                  ],
                ),
                Spacer(),
                Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
