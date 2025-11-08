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
    final textFieldTitleStyle =
        textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold);
    final viewModel = context.watch<SignupViewModel>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Create Your Account",
          style: textTheme.headlineMedium,
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Full Name", style: textFieldTitleStyle),
                              const SizedBox(height: 4),
                              TextFormField(
                                key: ValueKey("Full Name TextField"),
                                controller: viewModel.nameController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Enter your full name",
                                ),
                                validator: viewModel.validateName,
                              ),
                              const SizedBox(height: 16),
                    
                              Text("Email Address", style: textFieldTitleStyle),
                              const SizedBox(height: 4),
                              TextFormField(
                                key: ValueKey("Email Address TextField"),
                                controller: viewModel.emailController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Enter your email address",
                                ),
                                validator: viewModel.validateEmail,
                              ),
                              const SizedBox(height: 16),
                    
                              Text("Password", style: textFieldTitleStyle),
                              const SizedBox(height: 4),
                              TextFormField(
                                key: ValueKey("Password TextField"),
                                obscureText: true,
                                keyboardType: TextInputType.visiblePassword,
                                controller: viewModel.passwordController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Enter your password",
                                ),
                                validator: viewModel.validatePassword,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        FilledButton(
                          key: ValueKey("Signup Button"),
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            minimumSize: const Size(double.infinity, 60),
                          ),
                          onPressed: viewModel.enabled ? () {
                            _formKey.currentState!.validate();
                          } : null,
                          child: const Text("Signup"),
                        ),
                        const SizedBox(height: 16),
                    
                        const SeparatorLabel(text: "or sign up with"),
                        const SizedBox(height: 16),
                    
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClickableImage(
                              assetUrl: "assets/images/google.png",
                              onTap: () {},
                            ),
                            const SizedBox(width: 16),
                            ClickableImage(
                              assetUrl: "assets/images/facebook.png",
                              onTap: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                    
                        // 🔹 Redirect text
                        Center(
                          child: RedirectText(
                            onTap: () => context.go(Routes.login),
                            text: "Already have an account?",
                            redirectText: "Log in",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
