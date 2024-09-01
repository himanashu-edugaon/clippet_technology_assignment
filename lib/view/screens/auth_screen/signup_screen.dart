import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/auth_controller.dart';
import '../../../controller/db_helper.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_redirect.dart';
import '../../widgets/custom_textfield.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.find<AuthController>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int selectedProfessionIndex = 0;
  String? selectedProfession = "Select";
  late DbHelper dbHelper;
  var professionList = [
    "Select",
    "Student",
    "Job",
    "Business",
    "Self Employed",
    "Teacher",
    "Others"
  ];

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    final existingUser =
        await dbHelper.getUserByEmail(_emailController.text.trim());
    if (existingUser != null) {
      Get.snackbar("This Email is Already Taken.", "",
          backgroundColor: Colors.red);
    } else {
      final existingUser = await dbHelper.getUserByName(_nameController.text.trim());
      if (existingUser != null) {
        Get.snackbar("This Name is Already Taken.", "",
            backgroundColor: Colors.red);
      } else {
        if (_formKey.currentState!.validate()) {
          authController.signup(
            _nameController.text.trim(),
            _emailController.text.trim(),
            _passwordController.text.trim(),
            _phoneController.text.trim(),
            selectedProfession ?? "Others"
          );
          Get.snackbar("Register Successful!", "",
              backgroundColor: Colors.transparent,colorText: Colors.white);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "REGISTER",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Create An Account and Get Started",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(0.0, -60.0, 0.0),
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      CustomTextField(
                        controller: _nameController,
                        labelText: 'Name',
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _emailController,
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _phoneController,
                        labelText: 'Phone',
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: _passwordController,
                        labelText: 'Password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: selectedProfession,
                        validator: (value) {
                          if (value == "Select") {
                            return "Please Select Profession";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Profession",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Colors.blueAccent, width: 1.0),
                          ),
                        ),
                        items: professionList
                            .map(
                              (e) => DropdownMenuItem<String>(
                                child: Text(e),
                                value: e,
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedProfession = value;
                          });
                        },
                      ),
                      const SizedBox(height: 35),
                      CustomButton(
                        onPressed: _registerUser,
                        text: "Register",
                      ),
                      const SizedBox(height: 20),
                      CustomRedirect(
                        message: 'Already have an account? ',
                        linkText: 'Login',
                        Navigate: LoginScreen(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
