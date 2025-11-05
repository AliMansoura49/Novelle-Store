import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';

class LoginViewModel extends ChangeNotifier{
  

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isEmailValid = false;
  bool _isPasswordValid = false;

  String get email => emailController.text;
  String get password => passwordController.text;
  bool  get enabled => _isEmailValid && _isPasswordValid;


  LoginViewModel(){
    emailController.addListener(_updateState);
    passwordController.addListener(_updateState);
  }
  
  void _updateState(){
    final previous = enabled;

    _isEmailValid = emailController.text.isNotEmpty;
    _isPasswordValid = passwordController.text.isNotEmpty;
    if(enabled != previous){
      notifyListeners();
    }
  }

  String? validateEmail(String? value){
    if(value == null || !EmailValidator.validate(value)){
      return "Please enter a valid email address";
    }else{
      return null;
    }
  }
  String? validatePassword(String? value){
    if(value == null || value.trim().length < 8){
      return "Please enter at least 8 characters";
    }else {
      return null;
    }
  
  }

  @override
  void dispose() {

    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}