
import 'package:flutter_test/flutter_test.dart';
import 'package:store/ui/features/signup/view_model/signup_view_model.dart';

void main(){
  const validEmail = "example@gmail.com";
  const invalidEmail = "example%()gmail.com";
  const validPassword = "12345678";
  const invalidPassword = "1234";
  late SignupViewModel sut;

  setUp((){
    sut = SignupViewModel();
  });

  group('enable flag', (){
    
    test('should be false initailly', (){
      expect(sut.enabled, false);
    });

    test('should be false when one field is empty', (){
      sut.nameController.text = '';
      sut.passwordController.text = '123';
      sut.emailController.text = 'ali@gmail.com';
      expect(sut.enabled, false);
    });

    test('should be false when two fields are empty', (){
      sut.nameController.text = '';
      sut.passwordController.text = '';
      sut.emailController.text = 'ali@gmail.com';
      expect(sut.enabled, false);
    });

    test('should be true when all fields are filled', (){
      sut.nameController.text = 'ali';
      sut.passwordController.text = '123';
      sut.emailController.text = 'ali@gmail.com';
      expect(sut.enabled, true);
    });

  });

group('validateEmail', (){
    test('should return null when passing a valid email', (){
      //Act
      final error = sut.validateEmail(validEmail);
      //Assert
      expect(error, null);
    });

    test('should return non-null String when passing an invalid email', (){
      //Act
      final isValid = sut.validateEmail(invalidEmail);
      //Assert
      expect(isValid, isNotNull);
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
  group('notifyListeners', (){
    test('should notify listeners only when enabled state changes', (){
      var counter = 0;
      sut.addListener((){counter++;});

      sut.nameController.text = "ali";
      expect(counter, 0);

      sut.passwordController.text = validPassword;
      expect(counter, 0);

      sut.emailController.text = "al";
      expect(counter, 1);

      sut.emailController.text = "";
      expect(counter, 2);

    });

  });


}