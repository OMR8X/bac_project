import 'dart:math';

import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:bac_project/features/settings/domain/entities/app_settings.dart';
import 'package:bac_project/features/settings/domain/entities/governorate.dart';
import 'package:bac_project/features/settings/domain/entities/section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/helpers/input_validator.dart';
import '../../../core/injector/app_injection.dart';
import '../../../core/resources/styles/spaces_resources.dart';
import '../../../core/resources/themes/extensions/surface_container_colors.dart';
import '../../../core/widgets/ui/fields/drop_down_widget.dart';
import '../../../core/widgets/ui/fields/elevated_button_widget.dart';
import '../../../core/widgets/ui/fields/text_form_field_widget.dart';
import '../../../features/auth/domain/entites/user_data.dart';
import '../state/bloc/auth_bloc.dart';

class UpdateUserDataView extends StatefulWidget {
  const UpdateUserDataView({super.key});

  @override
  State<UpdateUserDataView> createState() => _UpdateUserDataViewState();
}

class _UpdateUserDataViewState extends State<UpdateUserDataView> {
  //
  late bool _didFillInfo = false;
  //
  late final GlobalKey<FormState> _formKey;
  //
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  //
  late Section _section;
  late Governorate _governorate;
  //
  @override
  void initState() {
    //
    _didFillInfo = false;
    //
    _formKey = GlobalKey<FormState>();
    //
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    //
    //
    _section = sl<AppSettings>().sections.firstWhere(
      (section) => section.id == sl<UserData>().sectionId,
    );
    _governorate = sl<AppSettings>().governorates.firstWhere(
      (governorate) => governorate.id == sl<UserData>().governorateId,
    );
    //
    initListeners();
    //
    super.initState();
  }

  initListeners() {
    _nameController.addListener(_updateButtonState);
    _emailController.addListener(_updateButtonState);
    _passwordController.addListener(_updateButtonState);
    _confirmPasswordController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    //
    _didFillInfo =
        _nameController.text.isNotEmpty ||
        _emailController.text.isNotEmpty ||
        _passwordController.text.isNotEmpty ||
        _confirmPasswordController.text.isNotEmpty;

    //
    if (!_didFillInfo &&
        _section.id == sl<UserData>().sectionId &&
        _governorate.id == sl<UserData>().governorateId) {
      _didFillInfo = false;
    }

    //
    setState(() {});
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() async {
    //
    String? name = _nameController.text.isNotEmpty ? _nameController.text : null;
    String? email = _emailController.text.isNotEmpty ? _emailController.text : null;
    String? password = _passwordController.text.isNotEmpty ? _passwordController.text : null;
    //
    sl<AuthBloc>().add(
      AuthUpdateUserDataEvent(
        name: name,
        email: email,
        governorateId: _governorate.id,
        sectionId: _section.id,
        password: password,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تغيير بيانات الحساب"),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.close, size: 20),
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
                    hintText: sl<UserData>().name,
                    position: 1,
                    keyboardType: TextInputType.name,
                    maxLength: 64,
                    controller: _nameController,
                    validator: (text) {
                      if (text?.isEmpty ?? true) return null;
                      return InputValidator.nameValidator(text);
                    },
                  ),
                  TextFormFieldWidget(
                    hintText: sl<UserData>().email,
                    maxLength: 64,
                    position: 2,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (text) {
                      if (text?.isEmpty ?? true) return null;
                      return InputValidator.emailValidator(text);
                    },
                  ),
                  TextFormFieldWidget(
                    hintText: "كلمة المرور",
                    maxLength: 64,
                    position: 3,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    validator: (text) {
                      if (text?.isEmpty ?? true) return null;
                      return InputValidator.passwordValidator(text);
                    },
                  ),
                  TextFormFieldWidget(
                    hintText: "تاكيد كلمة المرور",
                    maxLength: 64,
                    position: 4,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    controller: _confirmPasswordController,
                    validator: (text) {
                      if (_passwordController.text != _confirmPasswordController.text) {
                        return "كلمة المرور غير متطابقة";
                      }
                      if (text?.isEmpty ?? true) return null;
                      return InputValidator.passwordValidator(text);
                    },
                  ),
                  DropDownWidget<Governorate>(
                    hintText: "المحافظة",
                    initialSelection: sl<AppSettings>().governorates.firstWhere(
                      (governorate) => governorate.id == sl<UserData>().governorateId,
                    ),
                    entries: (sl<AppSettings>().governorates),
                    toLabel: (value) {
                      return value?.name ?? "غير محدد";
                    },
                    onSelected: (entry) {
                      //
                      _governorate = entry!;
                      //
                      if (entry.id != sl<UserData>().governorateId) {
                        setState(() => _didFillInfo = true);
                        return;
                      }
                      //
                      if (_nameController.text.isEmpty && _emailController.text.isEmpty) {
                        if (_passwordController.text.isEmpty &&
                            _confirmPasswordController.text.isEmpty) {
                          if (_section.id == sl<UserData>().sectionId) {
                            setState(() => _didFillInfo = false);
                          }
                        }
                      }
                    },
                  ),
                  // DropDownWidget<Section>(
                  //   hintText: "الفرع الدراسي",
                  //   initialSelection: sl<AppSettings>().sections.firstWhere(
                  //     (section) => section.id == sl<UserData>().sectionId,
                  //   ),
                  //   entries: (sl<AppSettings>().sections),
                  //   toLabel: (value) {
                  //     return value?.name ?? "غير محدد";
                  //   },
                  //   onSelected: (entry) {
                  //     //
                  //     _section = entry!;
                  //     //
                  //     if (entry.id != sl<UserData>().sectionId) {
                  //       setState(() => _didFillInfo = true);
                  //       return;
                  //     }
                  //     //
                  //     if (_nameController.text.isEmpty && _emailController.text.isEmpty) {
                  //       if (_passwordController.text.isEmpty &&
                  //           _confirmPasswordController.text.isEmpty) {
                  //         if (_governorate.id == sl<UserData>().governorateId) {
                  //           setState(() => _didFillInfo = false);
                  //         }
                  //       }
                  //     }
                  //   },
                  // ),
                  const SizedBox(height: SpacesResources.s10),
                  BlocProvider.value(
                    value: sl<AuthBloc>(),
                    child: BlocBuilder<AuthBloc, AuthState>(
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
                              state.loading ? CupertinoActivityIndicator() : Text("تغيير البيانات"),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: SpacesResources.s4),
                  const Text("اترك اي حقل لا ترغب بتغييره فارغ", style: AppTextStyles.underButton),
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
