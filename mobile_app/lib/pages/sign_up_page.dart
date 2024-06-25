import 'package:chatgpt_app/const.dart';
import 'package:chatgpt_app/main.dart';
import 'package:chatgpt_app/services/alert_services.dart';
import 'package:chatgpt_app/widget/custom_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey();
  final _auth = FirebaseAuth.instance;
  late NavigationService _navigationService;
  final GetIt _getIt = GetIt.instance;
  String? password, email, errorMessage;
  bool _passwordVisible = false;


  @override
  void initState() {
    super.initState();
    _navigationService = _getIt.get<NavigationService>();

    
  
  }
  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              
              Colors.black87,
              Colors.black87,

              ]
        
          ),
        ),
        child: _buildUI(),
      ),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
        child: Column(
          children: [
          
           SizedBox(height: MediaQuery.of(context).size.height*0.1),
            _signUpForm(),
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _signUpForm() {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.50,
        margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.01,
        ),
        child: Form(
          key: _loginFormKey,
          child: Column(
            children: [
              const Text(
                "Create Account",
                style: TextStyle(color: Colors.white,fontSize: 20),
                ),
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              _nameTextFormField(),
              SizedBox(height: MediaQuery.of(context).size.height*0.03),
              CustomFormField(
                prefixIcon: const Icon(Icons.email),
                suffixIcon: Icon(Icons.email_outlined),
                height: MediaQuery.of(context).size.height * 0.1,
                hintText: 'Email',
                validationRegEx: EMAIL_VALIDATION_REGEX,
                onSaved: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              CustomFormField(
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                onPressed:_togglePasswordVisibility,
                  icon:Icon(
                    _passwordVisible?Icons.visibility:Icons.visibility_off
                    
                    
                  ) ),
                height: MediaQuery.of(context).size.height * 0.1,
                hintText: 'Password',
                validationRegEx: PASSWORD_VALIDATION_REGEX,
                obscureText:!_passwordVisible,
                onSaved: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              _signUpButton(),
              SizedBox(height: MediaQuery.of(context).size.height*0.03),
              _accountHaveLink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nameTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon:const  Icon(Icons.person),
        hintText: "Full Name",
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          
        ),
        fillColor: Colors.white,
      ),
    );
  }

  Widget _signUpButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.05,
      child: MaterialButton(
        onPressed: () async {
          if (_loginFormKey.currentState!.validate()) {
            _loginFormKey.currentState!.save();
            setState(() {
              errorMessage = null;
            });
            try {
              final newUser = await _auth.createUserWithEmailAndPassword(
                email: email!,
                password: password!,
              );
              if (newUser != null) {
                Navigator.pushNamed(context, '/chat');
              }
            } catch (e) {
              setState(() {
                errorMessage = e.toString();
              });
            }
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Theme.of(context).colorScheme.primary,
        child: const Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.white,

            ),
        ),
      ),
    );
  }

  Widget _accountHaveLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         const Text(
          "Already have an account?",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            ),
        ),
        GestureDetector(
          onTap: () {
            _navigationService.pushName("/login");
          },
          child: const Text(
            " Log In",
            style: TextStyle(
              color: Colors.white, 
              fontWeight: FontWeight.w800,
              fontSize: 17
              ),
          ),
        ),
      ],
    );
  }
}
