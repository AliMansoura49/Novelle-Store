import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';

class SignupViewModel extends ChangeNotifier {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isNameValid = false;
  bool _isEmailValid = false;
  bool _isPasswordValid = false;


  bool  get enabled => _isEmailValid && _isNameValid && _isPasswordValid;

  SignupViewModel() {
    nameController.addListener(_updateState);
    emailController.addListener(_updateState);
    passwordController.addListener(_updateState);
  }

  void _updateState() {
    final previous = enabled;

    _isNameValid = validateName(nameController.text) == null;
    _isEmailValid = validateEmail(emailController.text) == null;
    _isPasswordValid = validatePassword(passwordController.text) == null;

    if (enabled != previous) {
      notifyListeners();
    }
  }

  String? validateName(String? value){
    if(value == null || value.trim().isEmpty){
      return "Please enter your name";
    }
    return null;
  }

  String? validateEmail(String? value){
    if(value == null || EmailValidator.validate(value)){
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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}