import 'package:x_change/Components/color.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:animate_do/animate_do.dart';

class ProfilePage extends StatefulWidget {
  final token;
  const ProfilePage({required this.token, super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    email = jwtDecodedToken['email'];
  }

  @override
  Widget build(BuildContext context) {
    String username = email.split('@')[0];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FadeInUp(
              duration: const Duration(milliseconds: 1000),
              child: Container(
                height: 320,
                width: double.infinity,
                padding: const EdgeInsets.only(left: 25, right: 25, top: 60),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50.0),
                      bottomLeft: Radius.circular(50.0)),
                  color: primaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeInUp(
                            duration: const Duration(milliseconds: 1250),
                            child: Text(
                              username,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                              ),
                            ),
                          ),
                          FadeInUp(
                            duration: const Duration(milliseconds: 1250),
                            child: const SizedBox(
                              width: 4,
                            ),
                          ),
                          FadeInUp(
                            duration: const Duration(milliseconds: 1250),
                            child: SizedBox(
                              height: 24,
                              child: Image.asset("assets/verified.png"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1320),
                      child: Text(
                        email,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, top: 20),
              height: size.height * .7,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FadeInUp(
                    duration: const Duration(milliseconds: 1350),
                    child: const ListTile(
                      leading: Icon(
                        Icons.bug_report_rounded,
                        color: Colors.black,
                        size: 25,
                      ),
                      title: Text(
                        'Report a bug',
                        style: TextStyle(fontSize: 19.5, color: Colors.black),
                      ),
                    ),
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1350),
                    child: const ListTile(
                      leading: Icon(
                        Icons.settings,
                        color: Colors.black,
                        size: 25,
                      ),
                      title: Text(
                        'Settings',
                        style: TextStyle(fontSize: 19.5, color: Colors.black),
                      ),
                    ),
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1350),
                    child: const ListTile(
                      leading: Icon(
                        Icons.notifications,
                        color: Colors.black,
                        size: 25,
                      ),
                      title: Text(
                        'Notifications',
                        style: TextStyle(fontSize: 19.5, color: Colors.black),
                      ),
                    ),
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1350),
                    child: const ListTile(
                      leading: Icon(
                        Icons.logout_rounded,
                        color: Colors.black,
                        size: 25,
                      ),
                      title: Text(
                        'Log Out',
                        style: TextStyle(fontSize: 19.5, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
