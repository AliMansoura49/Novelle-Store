
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:store/ui/features/login/view_model/login_view_model.dart';
import 'package:store/ui/features/login/widgets/login_screen.dart';

void main(){
  
  Widget createTestWidget(){
    return ChangeNotifierProvider(
      create: (_)=>LoginViewModel(),
      child: const MaterialApp(
        home: LoginScreen(),
      ),
    );
  }

  group('LoginScreen Widget Tests', (){
    
    testWidgets('Initially, Login button should be disabled',(tester)async{

      await tester.pumpWidget(createTestWidget());

      final loginButton = find.byKey(ValueKey("Login button"));

      expect(tester.widget<FilledButton>(loginButton).onPressed, isNull );
      
    });


    testWidgets('only one empty field disables the login button', (tester)async{

      await tester.pumpWidget(createTestWidget());

      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');

      await tester.enterText(find.byType(TextFormField).last, '');

      await tester.pump();

      final loginButton = find.byKey(ValueKey("Login button"));


      expect(tester.widget<FilledButton>(loginButton).onPressed, isNull);

      await tester.enterText(find.byType(TextFormField).first, '');

      await tester.enterText(find.byType(TextFormField).last, 'password');

      await tester.pump();

      expect(tester.widget<FilledButton>(loginButton).onPressed, isNull);


    });

    testWidgets('Entering email and password enables Login button', (tester) async{

      await tester.pumpWidget(createTestWidget());

      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');

      await tester.enterText(find.byType(TextFormField).last, 'password123');

      await tester.pump();
      
      final loginButton = find.byKey(ValueKey("Login button"));

      expect(tester.widget<FilledButton>(loginButton).onPressed, isNotNull);

    });

    testWidgets('Invalid email should show error', (tester)async{
      
      await tester.pumpWidget(createTestWidget());

      final emailTextField = find.byType(TextFormField).first;

      await tester.enterText(emailTextField, "invalid-email");
      await tester.enterText(find.byType(TextFormField).last, "password1234");

      final loginButton = find.byKey(ValueKey("Login button"));

      await tester.pump();

      await tester.tap(loginButton);

      await tester.pumpAndSettle();

      final text = find.text("Please enter a valid email address");

      expect(text, findsOneWidget);


    });

    testWidgets('Password less than 8 chars shows error', (tester) async {
      await tester.pumpWidget(createTestWidget());

      await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
      await tester.enterText(find.byType(TextFormField).last, '123');

      await tester.pump();

      await tester.tap(find.text('Log In'));
      
      await tester.pump();

      expect(find.text('Please enter at least 8 characters'), findsOneWidget);
    });
    
  });

}