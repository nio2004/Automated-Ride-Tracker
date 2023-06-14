// //import 'package:automated_ride_tracker/main.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// //import 'package:firebase_core/firebase_core.dart';
// import 'loginpage.dart';
// import 'dart:io';

// class Register extends StatefulWidget {
//   const Register({super.key});

//   @override
//   State<Register> createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   bool showProgress = false;
//   bool visible = false;

//   final _formkey = GlobalKey<FormState>();
//   final _auth = FirebaseAuth.instance;

//   final TextEditingController passwordController = new TextEditingController();
//   final TextEditingController confirmpassController =
//       new TextEditingController();
//   final TextEditingController name = new TextEditingController();
//   final TextEditingController emailController = new TextEditingController();
//   final TextEditingController mobile = new TextEditingController();

//   bool _isObscure = true;
//   bool _isObscure2 = true;
//   File? file;
//   var rool = "passenger";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create account'),
//       ),
//       body: Center(
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage('images/register.png'),
//                         fit: BoxFit.cover),
//                   ),
//                   child: Form(
//                     key: _formkey,
//                     child: Column(
//                       children: [
//                         TextFormField(
//                           controller: emailController,
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.white,
//                             hintText: 'Email',
//                             enabled: true,
//                           ),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return "Email cannot be empty";
//                             }
//                             if (!RegExp(
//                                     "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
//                                 .hasMatch(value)) {
//                               return ("Please enter a valid email");
//                             } else {
//                               return null;
//                             }
//                           },
//                           onChanged: (value) {},
//                           keyboardType: TextInputType.emailAddress,
//                         ),
//                         TextFormField(
//                           obscureText: _isObscure,
//                           controller: passwordController,
//                           decoration: InputDecoration(
//                             suffixIcon: IconButton(
//                                 icon: Icon(_isObscure
//                                     ? Icons.visibility_off
//                                     : Icons.visibility),
//                                 onPressed: () {
//                                   setState(() {
//                                     _isObscure = !_isObscure;
//                                   });
//                                 }),
//                             filled: true,
//                             fillColor: Colors.white,
//                             hintText: 'Password',
//                             enabled: true,
//                           ),
//                           validator: (value) {
//                             RegExp regex = new RegExp(r'^.{6,}$');
//                             if (value!.isEmpty) {
//                               return "Password cannot be empty";
//                             }
//                             if (!regex.hasMatch(value)) {
//                               return ("please enter valid password min. 6 character");
//                             } else {
//                               return null;
//                             }
//                           },
//                           onChanged: (value) {},
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         TextFormField(
//                           obscureText: _isObscure2,
//                           controller: confirmpassController,
//                           decoration: InputDecoration(
//                             suffixIcon: IconButton(
//                                 icon: Icon(_isObscure2
//                                     ? Icons.visibility_off
//                                     : Icons.visibility),
//                                 onPressed: () {
//                                   setState(() {
//                                     _isObscure2 = !_isObscure2;
//                                   });
//                                 }),
//                             filled: true,
//                             fillColor: Colors.white,
//                             hintText: 'Confirm Password',
//                             enabled: true,
//                           ),
//                           validator: (value) {
//                             if (confirmpassController.text !=
//                                 passwordController.text) {
//                               return "Password did not match";
//                             } else {
//                               return null;
//                             }
//                           },
//                           onChanged: (value) {},
//                         ),
//                         Row(
//                           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           // crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             MaterialButton(
//                               shape: RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(20.0))),
//                               elevation: 5.0,
//                               height: 40,
//                               onPressed: () {
//                                 setState(() {
//                                   showProgress = true;
//                                 });
//                                 signUp(emailController.text,
//                                     passwordController.text, rool);
//                               },
//                               child: Text(
//                                 "Register",
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                 ),
//                               ),
//                               color: Colors.white,
//                             ),
//                             MaterialButton(
//                               shape: RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(20.0))),
//                               elevation: 5.0,
//                               height: 40,
//                               onPressed: () {
//                                 Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => LoginPage()));
//                               },
//                               child: Text(
//                                 "Login",
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                 ),
//                               ),
//                               color: Colors.white,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ))
//             ]),
//       ),
//     );
//   }

//   void signUp(String email, String password, String rool) async {
//     CircularProgressIndicator();
//     if (_formkey.currentState!.validate()) {
//       await _auth
//           .createUserWithEmailAndPassword(email: email, password: password)
//           .then((value) => {postDetailsToFirestore(email, rool)})
//           .catchError((e) {});
//     }
//   }

//   postDetailsToFirestore(String email, String rool) async {
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     var user = _auth.currentUser;
//     CollectionReference ref = FirebaseFirestore.instance.collection('users');
//     ref.doc(user!.uid).set({'email': emailController.text, 'rool': rool});
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => LoginPage()));
//   }
// }
// // class CreateAccountPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return
// //   }
// // }

import 'package:automated_ride_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'loginpage.dart';
import 'dart:io';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

final _formkey = GlobalKey<FormState>();
final _auth = FirebaseAuth.instance;

class _RegisterState extends State<Register> {
  bool showProgress = false;
  bool visible = false;

  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmpassController =
      new TextEditingController();
  final TextEditingController name = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController mobile = new TextEditingController();

  bool _isObscure = true;
  bool _isObscure2 = true;
  File? file;
  var rool = "passenger";

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/register.png'), fit: BoxFit.cover)),
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 35, top: 30),
                  child: Text(
                    "Create\nAccount",
                    style: TextStyle(color: Colors.white, fontSize: 35),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.28,
                          right: 35,
                          left: 35),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            // TextFormField(
                            //   decoration: InputDecoration(
                            //       fillColor: Color.fromARGB(255, 149, 209, 235),
                            //       filled: true,
                            //       focusedBorder: OutlineInputBorder(
                            //           borderRadius: BorderRadius.circular(10),
                            //           borderSide: BorderSide(
                            //             color: Colors.black,
                            //           )),
                            //       enabledBorder: OutlineInputBorder(
                            //           borderRadius: BorderRadius.circular(10),
                            //           borderSide: BorderSide(
                            //             color: Colors.white,
                            //           )),
                            //       hintText: "Name",
                            //       hintStyle: TextStyle(color: Colors.white),
                            //       border: OutlineInputBorder(
                            //           borderRadius: BorderRadius.circular(10))),
                            // ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      )),
                                  hintText: "Email",
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email cannot be empty";
                                }
                                if (!RegExp(
                                        "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                    .hasMatch(value)) {
                                  return ("Please enter a valid email");
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {},
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      icon: Icon(_isObscure
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      }),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      )),
                                  hintText: "Password",
                                  enabled: true,
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              validator: (value) {
                                RegExp regex = new RegExp(r'^.{6,}$');
                                if (value!.isEmpty) {
                                  return "Password cannot be empty";
                                }
                                if (!regex.hasMatch(value)) {
                                  return ("please enter valid password min. 6 character");
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {},
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              obscureText: _isObscure2,
                              controller: confirmpassController,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      icon: Icon(_isObscure2
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure2 = !_isObscure2;
                                        });
                                      }),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      )),
                                  hintText: "Confirm Password",
                                  enabled: true,
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              validator: (value) {
                                if (confirmpassController.text !=
                                    passwordController.text) {
                                  return "Password did not match";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {},
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Color(0xff4c505b),
                                  child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      setState(() {
                                        showProgress = true;
                                      });
                                      signUp(emailController.text,
                                          passwordController.text, rool);
                                    },
                                    icon: Icon(Icons.arrow_forward),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, 'login');
                                    },
                                    child: Text("Log In",
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontSize: 18,
                                            color: Color.fromARGB(
                                                255, 250, 250, 250)))),
                              ],
                            )
                          ],
                        ),
                      )),
                )
              ],
            )));
  }

  void signUp(String email, String password, String rool) async {
    CircularProgressIndicator();
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore(email, rool)})
          .catchError((e) {});
    }
  }

  postDetailsToFirestore(String email, String rool) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.uid).set({'email': emailController.text, 'rool': rool});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
// class CreateAccountPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }
