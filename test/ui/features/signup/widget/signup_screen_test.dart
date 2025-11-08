import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:store/ui/features/signup/view_model/signup_view_model.dart';
import 'package:store/ui/features/signup/widgets/signup_screen.dart';

void main() {
  const fullNameKey = ValueKey("Full Name TextField");
  const emailTextFieldKey = ValueKey("Email Address TextField");
  const passwordTextFieldKey = ValueKey("Password TextField");
  const signupButtonKey = ValueKey("Signup Button");

  Widget createTestWidget() {
    return ChangeNotifierProvider(
      create: (_) => SignupViewModel(),
      child: MaterialApp(
        home: SignupScreen(),
      ),
    );
  }

  group('Signup Widget Test', () {
    testWidgets('Initially, signup button should be disabled', (tester) async {
      await tester.pumpWidget(createTestWidget());

      final signupButton = find.byKey(signupButtonKey);

      expect(tester.widget<FilledButton>(signupButton).onPressed, isNull);
    });


    testWidgets('should show email error when passing invalid email', (tester)async{
      await tester.pumpWidget(createTestWidget());

      final fullNameTextField = find.byKey(fullNameKey);
      final emailTextField = find.byKey(emailTextFieldKey);
      final passwordTextField = find.byKey(passwordTextFieldKey);
      final signupButton = find.byKey(signupButtonKey);


      await tester.enterText(fullNameTextField, 'test');
      await tester.enterText(emailTextField, 'invalid');
      await tester.enterText(passwordTextField, '12345678');
      await tester.pump();

      await tester.tap(signupButton);
      await tester.pump();

      expect(find.text("Please enter a valid email address"), findsOneWidget);

    });

    testWidgets('should show password error when passing password with less than 8 characters', (tester)async{
      await tester.pumpWidget(createTestWidget());

      final fullNameTextField = find.byKey(fullNameKey);
      final emailTextField = find.byKey(emailTextFieldKey);
      final passwordTextField = find.byKey(passwordTextFieldKey);
      final signupButton = find.byKey(signupButtonKey);


      await tester.enterText(fullNameTextField, 'test');
      await tester.enterText(emailTextField, 'ali@gmail.com');
      await tester.enterText(passwordTextField, '1234');
      await tester.pump();

      await tester.tap(signupButton);
      await tester.pump();

      expect(find.text("Please enter at least 8 characters"), findsOneWidget);

    });

    testWidgets(
      'Signup button should be disabled when only one field is filled',
      (tester) async {

        await tester.pumpWidget(createTestWidget());

        final fullNameTextField = find.byKey(fullNameKey);
        final emailTextField = find.byKey(emailTextFieldKey);
        final passwordTextField = find.byKey(passwordTextFieldKey);
        final signupButton = tester.widget<FilledButton>(
          find.byKey(signupButtonKey),
        );

        await tester.enterText(fullNameTextField, 'test');
        await tester.pump();

        expect(signupButton.onPressed, isNull);

        await tester.enterText(fullNameTextField, '');
        await tester.enterText(emailTextField, 'email');
        await tester.pump();
        expect(signupButton.onPressed, isNull);

        await tester.enterText(fullNameTextField, '');
        await tester.enterText(emailTextField, '');
        await tester.enterText(passwordTextField, '1234');

        await tester.pump();
        expect(signupButton.onPressed, isNull);
      },
    );
    testWidgets(
      'Signup button should be disabled when only one field is empty',
      (tester) async {
        await tester.pumpWidget(createTestWidget());


        final fullNameTextField = find.byKey(fullNameKey);
        final emailTextField = find.byKey(emailTextFieldKey);
        final passwordTextField = find.byKey(passwordTextFieldKey);
        final signupButton = tester.widget<FilledButton>(
          find.byKey(signupButtonKey),
        );


        await tester.enterText(fullNameTextField, '');
        await tester.enterText(emailTextField, 'name');
        await tester.enterText(passwordTextField, '1234');
        await tester.pump();

        expect(signupButton.onPressed, isNull);

        await tester.enterText(fullNameTextField, 'test');
        await tester.enterText(emailTextField, '');
        await tester.enterText(passwordTextField, '1234');
        await tester.pump();
        expect(signupButton.onPressed, isNull);

        await tester.enterText(fullNameTextField, 'test');
        await tester.enterText(emailTextField, 'email');
        await tester.enterText(passwordTextField, '');

        await tester.pump();
        expect(signupButton.onPressed, isNull);
      },
    );

    testWidgets(
      'Signup button should be enabled when all fields is filled',
          (tester) async {
        await tester.pumpWidget(createTestWidget());

        final fullNameTextField = find.byKey(fullNameKey);
        final emailTextField = find.byKey(emailTextFieldKey);
        final passwordTextField = find.byKey(passwordTextFieldKey);
        final signupButton = tester.widget<FilledButton>(
          find.byKey(signupButtonKey),
        );


        await tester.enterText(fullNameTextField, 'test');
        await tester.enterText(emailTextField, 'name');
        await tester.enterText(passwordTextField, '1234');
        await tester.pump();

        expect(signupButton.onPressed, isNull);

      },
    );
  });
}
