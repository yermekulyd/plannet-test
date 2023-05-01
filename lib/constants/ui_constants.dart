import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/pallete.dart';
import 'constants.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        // ignore: deprecated_member_use
        color: Pallete.blueColor,
      ),
      centerTitle: true,
    );
  }

  static List<Widget> bottomTabBarPages = [
    const Text('Feed Screen'),
    const Text('Search Screen'),
    const Text('Notification Screen'),
  ];
}
