
import 'package:flutter_test/flutter_test.dart';
import 'package:store/ui/features/login/view_model/login_view_model.dart';

void main(){
  late LoginViewModel sut;
  const validEmail = "example@gmail.com";
  const invalidEmail = "example%()gmail.com";
  const validPassword = "12345678";
  const invalidPassword = "1234";
  
  setUp((){
    sut = LoginViewModel();
  });
  
  group('validateEmail', (){
    test('should return null when passing a valid email', (){
      //Act
      final isValid = sut.validateEmail(validEmail);
      //Assert
      expect(isValid, null);
    });

    test('should return non-null String when passing an invalid email', (){
      //Act
      final error = sut.validateEmail(invalidEmail);
      //Assert
      expect(error, isNotNull);
    });
  });

  group('validatePassword', (){
    test('should return null when passing a valid password', (){
      //Act
      final error = sut.validatePassword(validPassword);
      //Assert
      expect(error, null);
    });

    test('should return null when passing an invalid password', (){
      //Act
      final error = sut.validatePassword(invalidPassword);
      //Assert
      expect(error, isNotNull);
    });
  });

  group('enable flag', (){
    
    test('should be false initially', (){
      expect(sut.enabled, false);
    });
    
    test('should be false when only email is valid', (){
      sut.emailController.text = validEmail;
      expect(sut.enabled, false);
    });
    
    test('should be false when only password is valid', () {
      sut.passwordController.text = validPassword;
      expect(sut.enabled, false);
    });
    
    test('should be true when both email and password are set', (){
      sut.passwordController.text = invalidPassword;
      sut.emailController.text = invalidPassword;
      expect(sut.enabled, true);
    });
  });
  
  group('notifyListeners', (){
    test('should notify listeners only when enabled state changes', (){
      var counter = 0;
      sut.addListener((){counter++;});

      sut.emailController.text = invalidEmail;
      expect(counter, 0);

      sut.passwordController.text = validPassword;
      expect(counter, 1);

      sut.emailController.text = "";
      expect(counter, 2);
    });

  });

}