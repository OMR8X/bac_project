import 'package:bac_project/core/extensions/build_context_l10n.dart';
import 'package:bac_project/core/helpers/input_validator.dart';
import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:bac_project/core/resources/styles/spaces_resources.dart';
import 'package:bac_project/core/resources/styles/spacing_resources.dart';
import 'package:bac_project/core/widgets/ui/fields/text_form_field_widget.dart';
import 'package:bac_project/core/widgets/ui/icons/close_icon_widget.dart';
import 'package:bac_project/presentation/auth/state/bloc/auth_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePasswordView extends StatefulWidget {
  const UpdatePasswordView({super.key});

  @override
  State<UpdatePasswordView> createState() => _UpdatePasswordViewState();
}

class _UpdatePasswordViewState extends State<UpdatePasswordView> {
  //
  late bool _didFillInfo = false;
  //
  late final GlobalKey<FormState> _formKey;
  //
  late final TextEditingController _currentPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;
  //
  @override
  void initState() {
    //
    _didFillInfo = false;
    //
    _formKey = GlobalKey<FormState>();
    //
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    //
    initListeners();
    //
    super.initState();
  }

  initListeners() {
    _currentPasswordController.addListener(_updateButtonState);
    _newPasswordController.addListener(_updateButtonState);
    _confirmPasswordController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    //
    _didFillInfo =
        _currentPasswordController.text.isNotEmpty &&
        _newPasswordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty;

    //
    setState(() {});
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() async {
    //
    sl<AuthBloc>().add(
      AuthUpdatePasswordEvent(
        currentPassword: _currentPasswordController.text,
        newPassword: _newPasswordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settingsUpdateMyPassword),
        leading: const CloseIconWidget(),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: Paddings.screenSidesPadding,
              child: Column(
                children: [
                  const SizedBox(height: SpacesResources.s10),
                  TextFormFieldWidget(
                    hintText: "كلمة المرور الحالية",
                    position: 1,
                    maxLength: 64,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    controller: _currentPasswordController,
                    validator: (text) {
                      if (text?.isEmpty ?? true) {
                        return "الرجاء إدخال كلمة المرور الحالية";
                      }
                      return null;
                    },
                  ),
                  TextFormFieldWidget(
                    hintText: "كلمة المرور الجديدة",
                    maxLength: 64,
                    position: 2,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    controller: _newPasswordController,
                    validator: (text) {
                      if (text?.isEmpty ?? true) {
                        return "الرجاء إدخال كلمة المرور الجديدة";
                      }
                      return InputValidator.passwordValidator(text);
                    },
                  ),
                  TextFormFieldWidget(
                    hintText: "تأكيد كلمة المرور الجديدة",
                    maxLength: 64,
                    position: 3,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    controller: _confirmPasswordController,
                    validator: (text) {
                      if (_newPasswordController.text != _confirmPasswordController.text) {
                        return "كلمة المرور غير متطابقة";
                      }
                      if (text?.isEmpty ?? true) {
                        return "الرجاء تأكيد كلمة المرور الجديدة";
                      }
                      return InputValidator.passwordValidator(text);
                    },
                  ),
                  const SizedBox(height: SpacesResources.s10),
                  BlocProvider.value(
                    value: sl<AuthBloc>(),
                    child: BlocBuilder<AuthBloc, AuthenticationState>(
                      builder: (context, state) {
                        return FilledButton(
                          style: FilledButton.styleFrom(
                            minimumSize: Size.fromHeight(SizesResources.buttonLargeHeight),
                          ),
                          onPressed:
                              state.loading
                                  ? null
                                  : _didFillInfo
                                  ? () {
                                    if (_formKey.currentState?.validate() ?? false) {
                                      _submit();
                                    }
                                  }
                                  : null,
                          child:
                              state.loading
                                  ? CupertinoActivityIndicator()
                                  : Text(context.l10n.settingsUpdateMyPassword),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: SpacesResources.s4),
                  const Text(
                    "يجب أن تكون كلمة المرور 8 أحرف على الأقل",
                    style: TextStylesResources.underButton,
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
