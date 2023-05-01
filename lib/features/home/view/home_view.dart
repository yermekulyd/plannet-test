import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/constants/assets_constants.dart';
import 'package:twitter_clone/constants/ui_constants.dart';
import 'package:twitter_clone/providers/user_provider.dart';
import 'package:twitter_clone/theme/pallete.dart';

import '../../tweet/views/create_tweet_view.dart';

class HomeView extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomeView());
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _page = 0;
  final appBar = UIConstants.appBar();

  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  void onPageChanged(int index) {
    setState(() {
      _page = index;
    });
  }

  void onCreateTweetScreen() {
    Navigator.push(context, CreateTweetScreen.route());
  }

  @override
  Widget build(BuildContext context) {
    // model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: appBar,
      body: IndexedStack(
        index: _page,
        children: UIConstants.bottomTabBarPages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onCreateTweetScreen,
        child: const Icon(
          Icons.add,
          color: Pallete.whiteColor,
          size: 28,
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(
          currentIndex: _page,
          onTap: onPageChanged,
          backgroundColor: Pallete.backgroundColor,
          items: [
            // Feed Tab
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _page == 0
                    ? AssetsConstants.homeFilledIcon
                    : AssetsConstants.homeOutlinedIcon,
                color: Pallete.whiteColor,
              ),
            ),

            // Search Tab
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AssetsConstants.searchIcon,
                color: Pallete.whiteColor,
              ),
            ),

            // Notifications Tab
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _page == 2
                    ? AssetsConstants.notifFilledIcon
                    : AssetsConstants.notifOutlinedIcon,
                color: Pallete.whiteColor,
              ),
            ),
          ]),
    );
  }

  // @override
  // void initState() {
  //   super.initState();
  //   addData();
  // }

  // addData() async {
  //   UserProvider _userProvider = Provider.of(context, listen: false);
  //   await _userProvider.refreshUser();
  // }

  // void signOutUser() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   String res = await AuthMethods().signOutUser();

  //   if (res == 'Success') {
  //     showSnackBar(context, 'Signed out successfully');
  //     // Navigator.push(context, HomeView.route());
  //   } else {
  //     showSnackBar(context, res);
  //   }

  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  // @override
  // Widget build(BuildContext context) {
  //   model.User user = Provider.of<UserProvider>(context).getUser;

  //   return _isLoading
  //       ? const LoadingPage()
  //       : Scaffold(
  //           body: Center(
  //               child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text('Hello, ${user.username}'),
  //               const SizedBox(
  //                 height: 20,
  //               ),
  //               Text('Your email: ${user.email}'),
  //               const SizedBox(
  //                 height: 20,
  //               ),
  //               RoundedSmallButton(
  //                 onTap: () {
  //                   signOutUser();
  //                 },
  //                 label: 'Sign out',
  //                 backgroundColor: Pallete.blueColor,
  //                 textColor: Pallete.whiteColor,
  //               )
  //             ],
  //           )),
  //         );
  // }
}
