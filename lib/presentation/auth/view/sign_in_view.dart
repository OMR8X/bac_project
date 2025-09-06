import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:bac_project/core/services/router/app_routes.dart';
import 'package:bac_project/core/widgets/ui/fields/text_form_field_widget.dart';
import 'package:bac_project/core/widgets/ui/icons/close_icon_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/helpers/input_validator.dart';
import '../../../core/resources/styles/spaces_resources.dart';
import '../../../core/resources/themes/extensions/surface_container_colors.dart';
import '../../../core/widgets/ui/fields/elevated_button_widget.dart';
import '../state/bloc/auth_bloc.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key, required this.state});
  final AuthSigningInState state;
  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  //
  late final GlobalKey<FormState> _formKey;
  //
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  //
  @override
  void initState() {
    //
    _formKey = GlobalKey<FormState>();
    //
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() async {
    sl<AuthBloc>().add(
      AuthSignInEvent(email: _emailController.text, password: _passwordController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تسجيل الدخول"),
        leading: CloseIconWidget(
          onPressed: () {
            context.read<AuthBloc>().add(const AuthStartAuthEvent());
          },
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: PaddingResources.screenSidesPadding,
              child: Column(
                children: [
                  const SizedBox(height: SpacesResources.s10),
                  TextFormFieldWidget(
                    hintText: "البريد الإلكتروني",
                    maxLength: 64,
                    position: 1,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (text) {
                      return InputValidator.emailValidator(text);
                    },
                  ),
                  TextFormFieldWidget(
                    hintText: "الرمز السري",
                    maxLength: 64,
                    obscureText: true,
                    maxLines: 1,
                    keyboardType: TextInputType.visiblePassword,
                    position: 2,
                    controller: _passwordController,
                    validator: (text) {
                      return InputValidator.passwordValidator(text);
                    },
                  ),
                  const SizedBox(height: SpacesResources.s10),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: Size.fromHeight(SizesResources.buttonLargeHeight),
                    ),
                    onPressed:
                        widget.state.loading
                            ? null
                            : () {
                              if (_formKey.currentState?.validate() ?? false) {
                                _submit();
                              }
                            },
                    child:
                        widget.state.loading
                            ? const CupertinoActivityIndicator()
                            : Text("تسجيل الدخول"),
                  ),
                  const SizedBox(height: SpacesResources.s20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
