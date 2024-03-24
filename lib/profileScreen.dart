import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moviesspace/Auth/Provider/auth_provider.dart';
import 'package:moviesspace/settingsScreenProvider.dart';
import 'package:provider/provider.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _selectedCountry;
  bool forgotPass = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    FormField()._focusNode.dispose();
    FormField()._focusNode2.dispose();
    FormField().nameController.dispose();
    FormField().passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AuthScreenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: forgotPass
          ? FormField()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.grey.shade200,
                    child: CircleAvatar(
                      radius: 70,
                      // backgroundImage: AssetImage('assets/images/default.png'),
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 50 + 50),
                  Consumer<SettingsScreenProvider>(
                    builder: (context, provider, _) {
                      return Center(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Country :",
                                  style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                DropdownButton<String>(
                                  value: provider.selectedCountry,
                                  onChanged: (newValue) {
//                                     if (newValue == "India") {
//                                       setState(() {
//                                         provider.changeCountry('in');
//                                       });
//                                     } else if (newValue == " United States") {
//                                       setState(() {
//                                         provider.changeCountry('us');
//                                       });
//                                     } else if (newValue == "United Arab Emirates") {
//   setState(() {
//     provider.changeCountry('ae');
//   });
// } else if (newValue == "Argentina") {
//   setState(() {
//     provider.changeCountry('ar');
//   });
// } else if (newValue == "Austria") {
//   setState(() {
//     provider.changeCountry('at');
//   });
// } else if (newValue == "Australia") {
//   setState(() {
//     provider.changeCountry('au');
//   });
// } else if (newValue == "Belgium") {
//   setState(() {
//     provider.changeCountry('be');
//   });
// } else if (newValue == "Bulgaria") {
//   setState(() {
//     provider.changeCountry('bg');
//   });
// } else if (newValue == "Brazil") {
//   setState(() {
//     provider.changeCountry('br');
//   });
// } else if (newValue == "Canada") {
//   setState(() {
//     provider.changeCountry('ca');
//   });
// } else if (newValue == "Switzerland") {
//   setState(() {
//     provider.changeCountry('ch');
//   });
// } else if (newValue == "China") {
//   setState(() {
//     provider.changeCountry('cn');
//   });
// } else if (newValue == "Colombia") {
//   setState(() {
//     provider.changeCountry('co');
//   });
// } else if (newValue == "Cuba") {
//   setState(() {
//     provider.changeCountry('cu');
//   });
// } else if (newValue == "Czech Republic") {
//   setState(() {
//     provider.changeCountry('cz');
//   });
// } else if (newValue == "Germany") {
//   setState(() {
//     provider.changeCountry('de');
//   });
// } else if (newValue == "Egypt") {
//   setState(() {
//     provider.changeCountry('eg');
//   });
// } else if (newValue == "France") {
//   setState(() {
//     provider.changeCountry('fr');
//   });
// } else if (newValue == "United Kingdom (Great Britain)") {
//   setState(() {
//     provider.changeCountry('gb');
//   });
// } else if (newValue == "Greece") {
//   setState(() {
//     provider.changeCountry('gr');
//   });
// } else if (newValue == "Hong Kong") {
//   setState(() {
//     provider.changeCountry('hk');
//   });
// } else if (newValue == "Hungary") {
//   setState(() {
//     provider.changeCountry('hu');
//   });
// } else if (newValue == "Indonesia") {
//   setState(() {
//     provider.changeCountry('id');
//   });
// } else if (newValue == "Ireland") {
//   setState(() {
//     provider.changeCountry('ie');
//   });
// } else if (newValue == "Israel") {
//   setState(() {
//     provider.changeCountry('il');
//   });
// } else if (newValue == "Italy") {
//   setState(() {
//     provider.changeCountry('it');
//   });
// } else if (newValue == "Japan") {
//   setState(() {
//     provider.changeCountry('jp');
//   });
// } else if (newValue == "South Korea (Republic of Korea)") {
//   setState(() {
//     provider.changeCountry('kr');
//   });
// } else if (newValue == "Lithuania") {
//   setState(() {
//     provider.changeCountry('lt');
//   });
// } else if (newValue == "Latvia") {
//   setState(() {
//     provider.changeCountry('lv');
//   });
// } else if (newValue == "Morocco") {
//   setState(() {
//     provider.changeCountry('ma');
//   });
// } else if (newValue == "Mexico") {
//   setState(() {
//     provider.changeCountry('mx');
//   });
// } else if (newValue == "Malaysia") {
//   setState(() {
//     provider.changeCountry('my');
//   });
// } else if (newValue == "Nigeria") {
//   setState(() {
//     provider.changeCountry('ng');
//   });
// } else if (newValue == "Netherlands") {
//   setState(() {
//     provider.changeCountry('nl');
//   });
// } else if (newValue == "Norway") {
//   setState(() {
//     provider.changeCountry('no');
//   });
// } else if (newValue == "New Zealand") {
//   setState(() {
//     provider.changeCountry('nz');
//   });
// } else if (newValue == "Philippines") {
//   setState(() {
//     provider.changeCountry('ph');
//   });
// } else if (newValue == "Poland") {
//   setState(() {
//     provider.changeCountry('pl');
//   });
// } else if (newValue == "Portugal") {
//   setState(() {
//     provider.changeCountry('pt');
//   });
// } else if (newValue == "Romania") {
//   setState(() {
//     provider.changeCountry('ro');
//   });
// } else if (newValue == "Serbia") {
//   setState(() {
//     provider.changeCountry('rs');
//   });
// } else if (newValue == "Russia") {
//   setState(() {
//     provider.changeCountry('ru');
//   });
// } else if (newValue == "Saudi Arabia") {
//   setState(() {
//     provider.changeCountry('sa');
//   });
// } else if (newValue == "Sweden") {
//   setState(() {
//     provider.changeCountry('se');
//   });
// } else if (newValue == "Singapore") {
//   setState(() {
//     provider.changeCountry('sg');
//   });
// } else if (newValue == "Slovenia") {
//   setState(() {
//     provider.changeCountry('si');
//   });
// } else if (newValue == "Slovakia") {
//   setState(() {
//     provider.changeCountry('sk');
//   });
// } else if (newValue == "Thailand") {
//   setState(() {
//     provider.changeCountry('th');
//   });
// } else if (newValue == "Turkey") {
//   setState(() {
//     provider.changeCountry('tr');
//   });
// } else if (newValue == "Taiwan") {
//   setState(() {
//     provider.changeCountry('tw');
//   });
// } else if (newValue == "Ukraine") {
//   setState(() {
//     provider.changeCountry('ua');
//   });
// } else if (newValue == "Venezuela") {
//   setState(() {
//     provider.changeCountry('ve');
//   });
// } else if (newValue == "South Africa") {
//   setState(() {
//     provider.changeCountry('za');
//   });
// }
                                    // setState(() {
                                    //   provider.changeCountry(newValue!);
                                    // });
                                  },
                                  items: provider.countries
                                      .map<DropdownMenuItem<String>>(
                                    (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          selectionColor: Colors.white,
                                          style: GoogleFonts.lato(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text(
                        "Name : " + prov.displayName!,
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width+40,
                      // ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              forgotPass = !forgotPass;
                            });
                          },
                          icon: Icon(
                            Icons.edit,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Email : ${prov.displayEmail}",
                        // +prov.user!.email.toString(),
                        textAlign: TextAlign.start,
                        style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
    );
  }
}

class FormField extends StatelessWidget {
  FormField({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AuthScreenProvider>(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Enter your New Name",
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              focusNode: _focusNode,
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
                labelStyle: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 20,
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(),
                errorBorder: OutlineInputBorder(),
                disabledBorder: OutlineInputBorder(),
                hintStyle: TextStyle(
                  color: Colors.black,
                ),
                hintText: "Enter your name",
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
              ),
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 20,
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              autocorrect: false,
            ),
            SizedBox(height: 16),
            TextFormField(
              focusNode: _focusNode2,
              controller: passController,
              decoration: InputDecoration(
                labelText: "Password",
                suffixIcon: IconButton(
                  icon: Icon(Icons.visibility),
                  onPressed: () {
                    // Toggle password visibility
                  },
                  color: Colors.black,
                ),
                labelStyle: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 20,
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(),
                errorBorder: OutlineInputBorder(),
                disabledBorder: OutlineInputBorder(),
                hintStyle: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 20,
                ),
                hintText: "Enter your password",
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
              ),
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 20,
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              autocorrect: false,
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  String _name = nameController.text.trim();
                  String _password = passController.text.trim();
                  _focusNode.unfocus();
                  _focusNode2.unfocus();
                  if (_name.isNotEmpty && _password.isNotEmpty) {
                    prov.updateUserNameAndPassword(context, _name, _password);
                  } else {
                    showTopSnackBar(
                      dismissType: DismissType.onSwipe,
                      Overlay.of(context),
                      CustomSnackBar.info(
                        message: "Make sure all the fields are filled!",
                      ),
                    );
                  }
                },
                child: Text(
                  "save",
                  style: GoogleFonts.lato(
                    fontSize: 20,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
