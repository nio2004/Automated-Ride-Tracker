// import 'package:automated_ride_tracker/navbar/pickup_time.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'registerpage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'homepages/admin.dart';
// import 'homepages/passenger.dart';
// import 'homepages/driver.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {

//   bool _isObscure3 = true;
//   bool visible = false;
//   final _formkey = GlobalKey<FormState>();
//   final TextEditingController emailController = new TextEditingController();
//   final TextEditingController passwordController = new TextEditingController();

//   //FirebaseAuth auth = FirebaseAuth.instance;
//   final _auth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login to Ride Tracker'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             Container(
//               child: Center(
//                 child: Container(
//                   margin: EdgeInsets.all(12),
//                   child: Form(
//                     key: _formkey,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           height: 30,
//                         ),
//                         Text(
//                           "Login",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             fontSize: 40,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         TextFormField(
//                           controller: emailController,
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: Colors.white,
//                             hintText: 'Email',
//                           ),
//                           validator: (value) {
//                             if (value!.length == 0) {
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
//                           onSaved: (value) {
//                             emailController.text = value!;
//                           },
//                           keyboardType: TextInputType.emailAddress,
//                         ),
//                          SizedBox(
//                           height: 20,
//                         ),
//                         TextFormField(
//                           controller: passwordController,
//                           obscureText: _isObscure3,
//                           decoration: InputDecoration(
//                             suffixIcon: IconButton(
//                                 icon: Icon(_isObscure3
//                                     ? Icons.visibility
//                                     : Icons.visibility_off),
//                                 onPressed: () {
//                                   setState(() {
//                                     _isObscure3 = !_isObscure3;
//                                   });
//                                 }),
//                             filled: true,
//                             fillColor: Colors.white,
//                             hintText: 'Password',
//                             enabled: true,
//                             contentPadding: const EdgeInsets.only(
//                                 left: 14.0, bottom: 8.0, top: 15.0),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: new BorderSide(color: Colors.white),
//                               borderRadius: new BorderRadius.circular(10),
//                             ),
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide: new BorderSide(color: Colors.white),
//                               borderRadius: new BorderRadius.circular(10),
//                             ),
//                           ),
//                           validator: (value) {
//                             RegExp regex = new RegExp(r'^.{3,}$');
//                             if (value!.isEmpty) {
//                               return "Password cannot be empty";
//                             }
//                             if (!regex.hasMatch(value)) {
//                               return ("please enter valid password min. 6 character");
//                             } else {
//                               return null;
//                             }
//                           },
//                           onSaved: (value) {
//                             passwordController.text = value!;
//                           },
//                           keyboardType: TextInputType.emailAddress,
//                         ),
//                          SizedBox(
//                           height: 20,
//                         ),
//                         MaterialButton(
//                           shape: RoundedRectangleBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(20.0))),
//                           elevation: 5.0,
//                           height: 40,
//                           onPressed: () {
//                             setState(() {
//                               visible = true;
//                             });
//                             signIn(emailController.text, passwordController.text);
//                           },
//                           child: Text(
//                             "Login",
//                             style: TextStyle(
//                               fontSize: 20,
//                             ),
//                           ),
//                           color: Colors.white,
//                         ),
//                          SizedBox(
//                       height: 20,
//                     ),
//                     MaterialButton(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(20.0),
//                         ),
//                       ),
//                       elevation: 5.0,
//                       height: 40,
//                       onPressed: () {
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => Register(),
//                           ),
//                         );
//                       },
//                       color: Colors.blue[900],
//                       child: Text(
//                         "Register Now",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           ),
//                         ),
//                       ),
//                     ]),
//                   ),
//                 ),
//               )
//             )
//           ]
//         )
//       )
//     );
//   }

//     void route() {
//     User? user = FirebaseAuth.instance.currentUser;
//     var kk = FirebaseFirestore.instance
//             .collection('users')
//             .doc(user!.uid)
//             .get()
//             .then((DocumentSnapshot documentSnapshot) {
//       if (documentSnapshot.exists) {
//         if (documentSnapshot.get('rool') == "passenger") {
//            Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) =>  Pickup(),
//           ),
//         );
//         }else if(documentSnapshot.get('rool') == "admin"){
//           Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) =>  Admin(),
//           ),
//         );
//         }
//       } else if(documentSnapshot.get('rool') == "driver"){
//           Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) =>  Driver(),
//           ),
//         );
//         }else {
//         print('Document does not exist on the database');
//       }
//     });
//   }

//   void signIn(String email, String password) async {
//     if (_formkey.currentState!.validate()) {
//       try {
//         UserCredential userCredential =
//             await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: email,
//           password: password,
//         );
//         route();
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'user-not-found') {
//           print('No user found for that email.');
//         } else if (e.code == 'wrong-password') {
//           print('Wrong password provided for that user.');
//           }
//         }
//       }
//     }

// }

// // class LoginPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return
// //   }
// // }

//import 'dart:js_util';

import 'package:automated_ride_tracker/navbar/pickup_time.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'registerpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'homepages/admin.dart';
import 'homepages/passenger.dart';
import 'homepages/driver.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

class _LoginPageState extends State<LoginPage> {
  bool _isObscure3 = true;
  bool visible = false;

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/login.png'), fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 35, top: 130),
                  child: Text(
                    "Welcome\nUser",
                    style: TextStyle(color: Colors.white, fontSize: 35),
                  ),
                ),
                SingleChildScrollView(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.5,
                        right: 35,
                        left: 35),
                    child: Container(
                      child: Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "Email",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                validator: (value) {
                                  if (value!.length == 0) {
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
                                onSaved: (value) {
                                  emailController.text = value!;
                                },
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
                                        icon: Icon(_isObscure3
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            _isObscure3 = !_isObscure3;
                                          });
                                          signIn(emailController.text,
                                              passwordController.text);
                                        }),
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "Password",
                                    enabled: true,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: Colors.white),
                                      borderRadius:
                                          new BorderRadius.circular(10),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: Colors.white),
                                      borderRadius:
                                          new BorderRadius.circular(10),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
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
                                onSaved: (value) {
                                  passwordController.text = value!;
                                },
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Sign In",
                                    style: TextStyle(
                                        fontSize: 27,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Color(0xff4c505b),
                                    child: IconButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          visible = true;
                                        });
                                        signIn(emailController.text,
                                            passwordController.text);
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, 'register');
                                      },
                                      child: Text("Sign Up",
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 18,
                                              color: Color(0xff4c505b)))),
                                  // TextButton(
                                  //     onPressed: () {},
                                  //     child: Text("Forgot Password",
                                  //         style: TextStyle(
                                  //             decoration: TextDecoration.underline,
                                  //             fontSize: 18,
                                  //             color: Color(0xff4c505b))))
                                ],
                              )
                            ],
                          )),
                    ))
              ],
            )));
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var kk = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('rool') == "passenger") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Passenger(),
            ),
          );
        } else if (documentSnapshot.get('rool') == "admin") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Admin(),
            ),
          );
        }
      } else if (documentSnapshot.get('rool') == "driver") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Driver(),
          ),
        );
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        route();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }
}
// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }
