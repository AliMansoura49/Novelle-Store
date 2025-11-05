import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:store/routing/routes.dart';
import 'package:store/ui/core/ui/buttons/clickable_image.dart';
import 'package:store/ui/core/ui/widgits/redirect_text.dart';
import 'package:store/ui/features/signup/view_model/signup_view_model.dart';

import '../../../core/ui/widgits/separator_label.dart';

class SignupScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;
    final textFieldTitleStyle = textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold);
    final viewModel = context.read<SignupViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Your Account",
          style: textTheme.displayMedium,
          ),
          
      ),
      body:Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUnfocus,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 8
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Full Name",style:textFieldTitleStyle),
                SizedBox(height: 4,),
                TextFormField(
                  controller: viewModel.nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your full name",
                  ),
                  validator: viewModel.validateName,
                ),
                SizedBox(height: 16,),
                Text("Email Address",style:textFieldTitleStyle),
                SizedBox(height: 4,),
                TextFormField(
                  controller: viewModel.emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your email address",
                  ),
                  validator: viewModel.validateEmail,
                ),
                SizedBox(height: 16,),
                Text("Password",style:textFieldTitleStyle),
                SizedBox(height: 4,),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: viewModel.passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your password",
                  ),
                  validator: viewModel.validatePassword,
                ),
                Spacer(flex: 1),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: Size(double.infinity, 60),
                    ),
                    onPressed: viewModel.enabled?(){}:null,
                  child: Text("Signup"),
                  ),
                SizedBox(height: 16,),
                SeparatorLabel(text: "or sign up with",),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClickableImage(
                      assetUrl: "assets/images/google.png",
                       onTap: (){}
                    ),
                    SizedBox(width: 16,),
                    ClickableImage(
                      assetUrl: "assets/images/facebook.png",
                       onTap: (){}
                    )
                  ]
                ),
                SizedBox(height: 16,),
                Center(
                  child: RedirectText(
                      onTap: (){
                        context.go(Routes.login);
                      },
                      text: "Already have an account?",
                      redirectText: "Log in"
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
