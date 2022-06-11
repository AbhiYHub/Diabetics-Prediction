import 'package:diabetes_prediction/models/user_model.dart';
import 'package:diabetes_prediction/pages/login_register/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetes_prediction/pages/navpages/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:radio_button_form_field/radio_button_form_field.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController dobController = TextEditingController();

  final TextEditingController genderController = TextEditingController();

  final TextEditingController heightController = TextEditingController();

  final TextEditingController weightController = TextEditingController();

  bool isLoading = false;



  var myNumber, myValue;

  final format = DateFormat("dd-MM-yyyy");
  late String birthDateInString;
  dynamic birthDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 40, right: 40, bottom: 40),
          // height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const Text(
                    "Sign up",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Create an account, It's free",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    makeInput(
                        label: "Name",
                        controller: nameController,
                        keyboardtype: TextInputType.name,
                        msg: "Please enter valid Name"),
                    makeInput(
                        label: "Email ID",
                        controller: emailController,
                        keyboardtype: TextInputType.emailAddress,
                        msg: "Please enter valid Email Address"),
                    makeInput(
                        label: "Password",
                        obscureText: true,
                        controller: passwordController,
                        keyboardtype: TextInputType.visiblePassword,
                        msg: "Please enter valid Password"),
                    const Text(
                      "Date of Birth",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    DateTimeField(
                      format: format,
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return msg;
                      //   }
                      //   return null;
                      // },

                      onShowPicker: (context, currentValue) {
                        var demo;
                        return showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime.now(),
                        );
                      },
                      // onFieldSubmitted: (value) {
                      //   birthDate = value!;
                      //   print("on field $birthDate $value");
                      // },
                      onChanged: (value) {
                        birthDate = value!;
                        print("on change $birthDate $value");
                      },
                      // onSaved: (value) {
                      //   birthDate = value!;
                      //   print("on saved $birthDate $value");
                      // },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade400)),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.shade400)),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Gender",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                    ),
                    RadioButtonFormField(
                      toggleable: true,
                      context: context,
                      value: 'value',
                      display: 'display',
                      data: data,
                      onSaved: (value) {
                          myNumber = value;
                          myValue = value.toString();
                          print("gender $myNumber $myValue");
                      },
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return "Please Select Gender";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    makeInput(
                        label: "Height",
                        controller: heightController,
                        keyboardtype: const TextInputType.numberWithOptions(
                            decimal: true),
                        msg: "Please enter valid height"),
                    makeInput(
                        label: "Weight",
                        controller: weightController,
                        keyboardtype: const TextInputType.numberWithOptions(
                            decimal: true),
                        msg: "Please enter valid weight"),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: const Border(
                      bottom: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                      left: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),
                    )),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    signUp(
                        emailController.text.trim(), passwordController.text);
                  },
                  color: Colors.greenAccent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: (isLoading)
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ))
                      : const Text(
                          "Sign up",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Already have an account?"),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage())),
                    child: const Text(
                      " Login",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.greenAccent),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeInput(
      {label, obscureText = false, controller, keyboardtype, msg}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          obscureText: obscureText,
          controller: controller,
          keyboardType: keyboardtype,
          onSaved: (value) {
            controller.text = value!;
          },
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value!.isEmpty) {
              return msg;
            }
            return null;
          },
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      FocusManager.instance.primaryFocus?.unfocus();
      print("$email $password");
      _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => postDetailsToFirestore())
          .catchError((e) {
        // Fluttertoast.showToast(msg: e.message);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
        ));
        setState(() {
          isLoading = false;
        });
        print(e);
      });
    }
  }

  postDetailsToFirestore() async {
    print("Hello");
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    // print("$userModel");
    userModel.uid = user!.uid;
    userModel.name = nameController.text;
    userModel.email = user.email;
    userModel.dob = birthDate.toString();
    userModel.gender = myValue.toString();
    userModel.height = heightController.text;
    userModel.weight = weightController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Registration Successful'),
    ));

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
        (route) => false);
  }
}

  final List<Map> data = [
    {'value': 'Male', 'display': 'Male'},
    {'value': 'Female', 'display': 'Female'}
  ];