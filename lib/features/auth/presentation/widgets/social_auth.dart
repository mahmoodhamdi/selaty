import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selaty/core/constants/colors.dart';
import 'package:selaty/core/constants/styles.dart';
import 'package:selaty/core/device/device_utility.dart';
import 'package:selaty/features/auth/presentation/widgets/register_button.dart';

class SocialAuth extends StatelessWidget {
  const SocialAuth({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    final isPortrait = TDeviceUtils.isLandscapeOrientation(context);
    final width = TDeviceUtils.getScreenWidth(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(text, style: Styles.textStyle16),
        const SizedBox(height: 10),
        Row(
          children: [
            const Expanded(
              child: RegisterButton(
                text: 'Facebook',
                color: Color(0xff3C5A9A),
                icon: FaIcon(
                  FontAwesomeIcons.facebookF,
                  size: 24,
                  color: Color(0xff3C5A9A),
                ),
              ),
            ),
            SizedBox(width: isPortrait ? width * 0.09 : width * 0.09),
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
