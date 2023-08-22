import 'package:blackcoffer/resources/authentication.dart';
import 'package:blackcoffer/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/global_variables.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _isLoading = false;
  bool _isCodeSent = false;
  bool _isOtpVerified = false;

  String verify = "";
  String btnText = "Send OTP";
  var phone = "";
  var code = "";

  TextEditingController countryController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+91";
    super.initState();
  }

  void signIn()async{
    String output =
        await AuthenticationMethods()
        .signUpUser(
      phone: phone,

    );
    if (output == "success") {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  HomeScreen()));
    } else {
     showSnackBar(
          context, output);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double height = 520;
    double width = 300;

    if (screenSize.width > 500) {
      setState(() {
        height = 520;
        width = 450;
      });
    } else {
      setState(() {
        height = 520;
        width = screenSize.width - 48;
      });
    }

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.blue.shade100,
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: width,
                  height: height,
                  child: Center(
                    child: PhysicalModel(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(26),
                      shadowColor: Colors.blue,
                      elevation: 7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const  SizedBox(
                            height: 16,
                          ),
                          const Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: 32),
                                child: Text(
                                  "Login to BlackCoffer",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),

                          const SizedBox(
                            height: 30,
                          ),
                         Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 32),
                                child: TextField(
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.next,
                                  maxLength: 10,
                                  onChanged: (value) {
                                    phone = value;
                                  },
                                  style: TextStyle(fontSize: 12),
                                  decoration: InputDecoration(
                                    label: Text("Enter Your Phone No."),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(5),
                                        borderSide:
                                        BorderSide(color: Colors.blue)),
                                  ),
                                ),
                              ),
                          SizedBox(
                            height: 12,
                          ),
                         Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 32),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  onChanged: (value) {
                                    code = value;
                                  },
                                  style: TextStyle(fontSize: 12),
                                  decoration: InputDecoration(
                                    label: Text("Enter Your OTP"),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(5),
                                        borderSide:
                                        BorderSide(color: Colors.blue)),
                                  ),
                                ),
                              ),
                          SizedBox(
                            height: 2,
                          ),
                         Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 32),
                              child: Text(
                                "*We have sent an One Time Password(OTP) to this Number",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey.shade400),
                              ),
                            ),
                          SizedBox(
                            height: 18,
                          ),
                          Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 32),
                              child: Text(
                                "By filling this form, I agree to Term of Use",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black87),
                              ),
                            ),
                          SizedBox(
                            height: 32,
                          ),
                          SizedBox(
                              width: double.infinity,
                              height: 46,
                              child:
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32),
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        if (phone.length < 10) {
                                          showSnackBar(context,
                                              "Phone No. should contain 10 digits!!!");
                                        } else if (!_isCodeSent &&
                                            !_isOtpVerified) {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          try {
                                            await FirebaseAuth.instance
                                                .verifyPhoneNumber(
                                              phoneNumber:
                                              '${countryController.text + phone}',
                                              verificationCompleted:
                                                  (PhoneAuthCredential
                                              credential) {},
                                              verificationFailed:
                                                  (FirebaseAuthException e) {
                                                setState(() {
                                                  _isLoading = false;
                                                });
                                              },
                                              codeSent: (String verificationId,
                                                  int? resendToken) async {
                                                setState(() {
                                                  _isLoading = false;
                                                  _isCodeSent = true;
                                                  verify = verificationId;
                                                  btnText = "Verify Otp";
                                                });
                                                // Navigator.push(context, MaterialPageRoute(builder: (_)=>MyVerify()));
                                              },
                                              codeAutoRetrievalTimeout:
                                                  (String verificationId) {},
                                            );
                                          } catch (e) {
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            showSnackBar(
                                                context, "Otp send failed!!!");
                                          }
                                        } else if (_isCodeSent &&
                                            !_isOtpVerified) {
                                          try {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            PhoneAuthCredential credential =
                                            PhoneAuthProvider.credential(
                                                verificationId: verify,
                                                smsCode: code);

                                            // Sign the user in (or link) with the credential
                                            await auth
                                                .signInWithCredential(
                                                credential)
                                                .then((value) {
                                              setState(() {
                                                _isOtpVerified = true;
                                                btnText = "Continue";
                                                _isLoading = false;
                                                showSnackBar(
                                                    context, "Otp Verified!!");
                                                signIn();
                                              });
                                            });
                                          } catch (e) {
                                            showSnackBar(
                                                context, "Wrong Otp");
                                            setState(() {
                                              _isLoading = false;
                                            });
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: StadiumBorder()),
                                      child: _isLoading
                                          ? CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      )
                                          : Text(btnText)),
                                ),
                              ),


                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
