import 'package:chatgpt_app/const.dart';
import 'package:chatgpt_app/main.dart';
import 'package:chatgpt_app/services/alert_services.dart';
import 'package:chatgpt_app/services/auth_service.dart';
import 'package:chatgpt_app/widget/custom_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final GetIt _getIt = GetIt.instance;
  final GlobalKey<FormState> _loginFormKey = GlobalKey();

  late AuthService _authService;
  late NavigationService _navigationService;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late AlertServices _alertServices;
   bool _passwordVisible = false;

  String? email, password;
  User? _user;

  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
    _alertServices = _getIt.get<AlertServices>();
    _auth.authStateChanges().listen((event) {
      _user = event;
    });
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
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0, 
          vertical: 30.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.07,),
            
            
            _loginForm(),
            
          ],
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.60,
        margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.05,
        ),
        child: Form(
          key: _loginFormKey,
          child: Column(
            children: [
              _header(),
              SizedBox(height: MediaQuery.of(context).size.height*0.03,),
              CustomFormField(
                suffixIcon: Icon(Icons.email_outlined),
                prefixIcon: const Icon(Icons.email),
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
                obscureText: !_passwordVisible,
                onSaved: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              _loginButton(),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 const Text(
                    "Don't have account ? ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    ),
                    GestureDetector(
                      onTap: (){
                        _navigationService.pushName("/sign");
                      },
                      child: const Text(
                        "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                        ),
                        ),
                    )
                ],
              ),
               SizedBox(height: MediaQuery.of(context).size.height*0.03,),
              _signUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.05,
      child: MaterialButton(
        onPressed: () async {
          if (_loginFormKey.currentState?.validate() ?? false) {
            _loginFormKey.currentState?.save();
            bool result = await _authService.login(email!, password!);
            print(result);
            if (result) {
              _navigationService.pushReplacementNamed("/home");
            } else {
              _alertServices.showToast(
                text: "Failed to login, please try again!",
                icon: Icons.error
                );
              // Handle login failure
          
            }
          }
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        
        color: Theme.of(context).colorScheme.primary,
        child: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        
      ),
    );
  }

  Widget _signUpButton() {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.06,
      width: MediaQuery.of(context).size.width,
      child: SignInButton(
        Buttons.google,
        text: "Sign Up with Google",
        onPressed: _handleGoogleSignIn,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      ),
    );
  }
  Widget _header(){
    return const Column(
      children: [
       
        Text(
          "WelCome to Chat bot ",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20
            ),
            )
      ],
    );

  }
  

  void _handleGoogleSignIn() async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      // The user canceled the sign-in
      print("Sign-in cancelled by user");
      return;
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential = await _auth.signInWithCredential(credential);
    final User? user = userCredential.user;

    if (user != null) {
      // Successful sign-in
      print("Signed in with Google: ${user.uid}");
      _navigationService.pushReplacementNamed("/home");
    }
  } catch (error) {
    print("Error during Google sign-in: $error");
    _alertServices.showToast(
       text: "Failed to login, please try again!",
       icon: Icons.error
        );

   
  }
}

}


