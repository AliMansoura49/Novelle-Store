import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:store/routing/routes.dart';
import 'package:store/ui/core/ui/widgits/redirect_text.dart';
import 'package:store/ui/core/ui/widgits/rounded_icon_box.dart';
import '../../../core/ui/widgits/separator_label.dart';
import '../view_model/login_view_model.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obsecureText = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final textFieldTitleStyle = textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold);
    final viewModel = context.read<LoginViewModel>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Brand Icon
                  const RoundedIconBox(),
                  const SizedBox(height: 16),
                  Text(
                    "Welcome Back",
                    style: textTheme.displaySmall,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Log in to your account to continue.",
                    style: textTheme.titleLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Consumer<LoginViewModel>(
                    builder: (context, vm, child) => Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email Address", style: textFieldTitleStyle),
                          const SizedBox(height: 4),
                          TextFormField(
                            controller: viewModel.emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Enter your email address",
                            ),
                            validator: viewModel.validateEmail,
                          ),
                          const SizedBox(height: 16),
                          Text("Password", style: textFieldTitleStyle),
                          const SizedBox(height: 4),
                          TextFormField(
                            obscureText: _obsecureText,
                            keyboardType: TextInputType.visiblePassword,
                            controller: viewModel.passwordController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obsecureText = !_obsecureText;
                                  });
                                },
                                icon: Icon(
                                  _obsecureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Enter your password",
                            ),
                            validator: viewModel.validatePassword,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Spacer(),

                  Selector<LoginViewModel, bool>(
                    selector: (context, vm) => vm.enabled,
                    builder: (context, enabled, child) => FilledButton(
                      key: ValueKey("Login button"),
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(double.infinity, 60),
                      ),
                      onPressed: enabled
                          ? () {
                              _formKey.currentState!.validate();
                            }
                          : null,
                      child: const Text("Log In"),
                    ),
                  ),

                  const SizedBox(height: 24),
                  const SeparatorLabel(text: "OR"),
                  const SizedBox(height: 16),

                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: Image.asset("assets/images/google.png"),
                          ),
                          const SizedBox(width: 8),
                          const Text("Continue with Google"),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: Image.asset("assets/images/facebook.png"),
                          ),
                          const SizedBox(width: 8),
                          const Text("Continue with Facebook"),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  RedirectText(
                    onTap: () {
                      context.go(Routes.signup);
                    },
                    text: "Don't have an account?",
                    redirectText: "Sign up",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   bool _obsecureText = false;

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     final colorScheme = Theme.of(context).colorScheme;
//     final textFieldTitleStyle = textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold);
//     final viewModel = context.read<LoginViewModel>();
  
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//         bottom: false,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             vertical: 16,
//             horizontal: 8
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               //Brand Icon
//               RoundedIconBox(),
//               SizedBox(height: 16,),
//               Text(
//                 "Wellcome Back",
//                 style: textTheme.displaySmall,
//               ),
//               SizedBox(height: 16,),
//               Text(
//                 "Log in to your account to continue.",
//                 style: textTheme.titleLarge?.copyWith(
//                   color: colorScheme.onSurfaceVariant
//                 ),
//               ),
//               SizedBox(height: 24,),
//               Consumer<LoginViewModel>(
//                 builder: (context,vm,child)=> Form(
//                   key: _formKey,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Emaifl Address",style:textFieldTitleStyle),
//                   SizedBox(height: 4,),
//                   TextFormField(
//                     controller: viewModel.emailController,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                       hintText: "Enter your email address",
//                     ),
//                     validator: viewModel.validateEmail,
//                   ),
//                   SizedBox(height: 16,),
//                   Text("Password",style:textFieldTitleStyle),
//                   SizedBox(height: 4,),
//                   TextFormField(
//                     obscureText: _obsecureText,
//                     keyboardType: TextInputType.visiblePassword,
//                     controller: viewModel.passwordController,
//                     decoration: InputDecoration(
//                       suffixIcon: IconButton(
//                           onPressed: (){
//                             setState(() {
//                               _obsecureText = !_obsecureText;
//                             });
//                           },
//                           icon:Icon(
//                             _obsecureText?
//                               Icons.visibility: Icons.visibility_off
//                           )
//                       ),
                  
//                       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                       hintText: "Enter your password",
//                     ),
//                     validator: viewModel.validatePassword,
//                   )
//                   ],
//                   )
//                 )
//               ),
//               Spacer(flex: 1,),
//               Selector<LoginViewModel,bool>(
//                   selector: (context,vm)=>vm.enabled,
//                   builder: (context,enabled,child)=>FilledButton(
//                     style: FilledButton.styleFrom(
                      
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       minimumSize: Size(double.infinity, 60),
//                     ),
//                     onPressed: enabled?(){
//                       _formKey.currentState!.validate();
//                     }:null,
//                     child: Text("Log In"),
//                   ),
//               ),
//               SizedBox(height: 24,),
//               SeparatorLabel(text: "OR",),
//               SizedBox(height: 16,),
//               OutlinedButton(
//                   style: OutlinedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)
//                     )
//                   ),
//                   onPressed: (){},
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center ,
//                       children: [
//                         SizedBox(
//                           width: 30,
//                           height: 30,
//                           child: Image.asset("assets/images/google.png")
//                         ),
//                         SizedBox(width: 8,),
//                         Text("Continue with Google")
//                       ],
//                     ),
//                   )
//               ),
//               SizedBox(height: 16,),
//               OutlinedButton(
//                   style: OutlinedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)
//                     )
//                   ),
//                   onPressed: (){},
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center ,
//                       children: [
//                         SizedBox(
//                           width: 30,
//                           height: 30,
//                           child: Image.asset("assets/images/facebook.png")
//                         ),
//                         SizedBox(width: 8,),
//                         Text("Continue with Facebook")
//                       ],
//                     ),
//                   )
//               ),
//               SizedBox(height: 24,),
//               RedirectText(
//                 onTap: (){
//                   context.go(Routes.signup);
//                 },
//               text: "Don't have an account?",
//                 redirectText: "Sign up"
//               )
//             ],
                  
                  
//           ),
//         ),
//       ),
//     );
//   }
// }

