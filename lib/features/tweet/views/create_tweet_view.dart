import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_clone/common/common.dart';
// import 'package:twitter_clone/features/auth/view/login_view.dart';

import 'package:provider/provider.dart';
import '../../../providers/user_provider.dart';
import 'package:twitter_clone/models/user.dart' as model;
import '../../../theme/pallete.dart';

class CreateTweetScreen extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const CreateTweetScreen());

  const CreateTweetScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CreateTweetScreenState();
}

class _CreateTweetScreenState extends State<CreateTweetScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close, size: 30),
        ),
        actions: [
          RoundedSmallButton(
            onTap: () async {
              // TEMPORARY: Sign out the user
              await _auth.signOut();
            },
            label: user.username, // !! Change to "Tweet" !!
            backgroundColor: Pallete.blueColor,
            textColor: Pallete.whiteColor,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.photoUrl != ''
                        ? user.photoUrl
                        : 'https://mybroadband.co.za/news/wp-content/uploads/2017/04/Twitter-profile-picture.jpg'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
