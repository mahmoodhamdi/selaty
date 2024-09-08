import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/features/auth/presentation/widgets/register_button.dart';
import 'package:selaty/features/home/presentation/views/main_view.dart';

class SocialAuth extends StatelessWidget {
  const SocialAuth({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    final isPortrait =
        Orientation.portrait == MediaQuery.of(context).orientation;
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(text, style: Styles.textStyle16),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainView()));
                },
                child: const RegisterButton(
                  text: 'Facebook',
                  color: Color(0xff3C5A9A),
                  icon: FaIcon(
                    FontAwesomeIcons.facebookF,
                    size: 24,
                    color: Color(0xff3C5A9A),
                  ),
                ),
              ),
            ),
            SizedBox(
                width: isPortrait ? screenWidth * 0.09 : screenWidth * 0.09),
            const Expanded(
              child: RegisterButton(
                color: primaryRed,
                text: 'Google',
                icon: FaIcon(
                  FontAwesomeIcons.googlePlusG,
                  size: 24,
                  color: primaryRed,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
