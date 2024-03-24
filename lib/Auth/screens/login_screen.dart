import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moviesspace/Auth/Provider/auth_provider.dart';
import 'package:moviesspace/Auth/utils/animations.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../data/bg_data.dart';
import '../utils/text_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int selectedIndex = 0;
  bool showOption = false;
  String email = '';
  String password = '';
  String name = '';
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _name = TextEditingController();
  bool signup = false;

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
    _name.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthScreenProvider>(context);
    return Scaffold(
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 49,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
                child: showOption
                    ? ShowUpAnimation(
                        delay: 100,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: bgList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: selectedIndex == index
                                      ? Colors.white
                                      : Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(1),
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage(
                                        bgList[index],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                    : const SizedBox()),
            const SizedBox(
              width: 20,
            ),
            showOption
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        showOption = false;
                      });
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    ))
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        showOption = true;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(
                            bgList[selectedIndex],
                          ),
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(bgList[selectedIndex]), fit: BoxFit.fill),
        ),
        alignment: Alignment.center,
        child: Container(
          height: 400,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
            color: Colors.black.withOpacity(0.1),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (signup) const Spacer(),
                      Center(
                          child: TextUtil(
                        text: signup ? "SignUp" : "Login",
                        weight: true,
                        size: 30,
                      )),
                      const Spacer(),
                      if (signup)
                        TextUtil(
                          text: "Name",
                        ),
                      if (signup)
                        Container(
                          height: 35,
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.white))),
                          child: TextFormField(
                            controller: _name,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              fillColor: Colors.white,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      if (signup) const Spacer(),
                      TextUtil(
                        text: "Email",
                      ),
                      Container(
                        height: 35,
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.white))),
                        child: TextFormField(
                          controller: _email,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            suffixIcon: Icon(
                              Icons.mail,
                              color: Colors.white,
                            ),
                            fillColor: Colors.white,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const Spacer(),
                      TextUtil(
                        text: "Password",
                      ),
                      Container(
                        height: 35,
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.white))),
                        child: TextFormField(
                          controller: _password,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            suffixIcon: Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                            fillColor: Colors.white,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Container(
                            height: 15,
                            width: 15,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: TextUtil(
                            text: "Remember Me , FORGET PASSWORD",
                            size: 12,
                            weight: true,
                          ))
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          String email = _email.text.trim();
                          String password = _password.text.trim();
                          String name = _name.text.trim();
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (!signup) {
                            if (email.isNotEmpty &&
                                password.isNotEmpty &&
                                email != null &&
                                password != null) {
                              provider.login(context, email, password);
                              
                            } else
                              // provider.isLoading = false;
                              showTopSnackBar(
                                  dismissType: DismissType.onSwipe,
                                Overlay.of(context),
                                CustomSnackBar.info(
                                  message: "Email or Password is empty",
                                ),
                              );
                          } else if(signup && email.isNotEmpty &&
                                password.isNotEmpty &&
                                email != null &&
                                password != null&&
                                name !=null){
                            provider.signUpWithEmailAndPassword(
                                context, email, password, name);
                            
                          }
                          else
                              // provider.isLoading = false;
                              showTopSnackBar(
                                dismissType: DismissType.onSwipe,
                                Overlay.of(context),
                                CustomSnackBar.info(
                                  message: "Make sure all the fields are filled!",
                                ),
                              );
                          } ,
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          alignment: Alignment.center,
                          child: TextUtil(
                            text: signup ? 'SignUp' : "Log In",
                            color: Colors.black,
                          ),
                          // ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            signup = !signup;
                          });
                        },
                        child: Center(
                            child: TextUtil(
                          text: signup
                              ? "Already have an account SignIn?"
                              : "Don't have a account REGISTER?",
                          size: 12,
                          weight: true,
                        )),
                      ),
                      const Spacer(),
                      if (provider.isLoading)
                        SpinKitWaveSpinner(color: Colors.white, size: 50.0),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
