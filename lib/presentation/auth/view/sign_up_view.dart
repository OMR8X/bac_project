import 'package:bac_project/core/resources/styles/padding_resources.dart';
import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:bac_project/core/services/router/app_routes.dart';
import 'package:bac_project/core/widgets/ui/icons/close_icon_widget.dart';
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
import '../state/bloc/auth_bloc.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key, required this.state});
  final AuthSigningUpState state;
  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
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
    _formKey = GlobalKey<FormState>();
    //
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    //
    _section = widget.state.sections.first;
    _governorate = widget.state.governorates.first;
    //
    super.initState();
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
    sl<AuthBloc>().add(
      AuthSignUpEvent(
        name: _nameController.text,
        email: _emailController.text,
        sectionId: _section.id,
        governorateId: _governorate.id,
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("انشاء حساب جديد"),
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
                    hintText: "الاسم",
                    position: 1,
                    keyboardType: TextInputType.name,
                    maxLength: 64,
                    controller: _nameController,
                    validator: (text) {
                      return InputValidator.nameValidator(text);
                    },
                  ),
                  TextFormFieldWidget(
                    hintText: "البريد الإلكتروني",
                    maxLength: 64,
                    position: 2,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (text) {
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
                      return InputValidator.passwordValidator(text);
                    },
                  ),
                  const SizedBox(height: SpacesResources.s5),
                  DropDownWidget<Governorate>(
                    hintText: "المحافظة",
                    initialSelection: sl<AppSettings>().governorates.firstWhere(
                      (governorate) => governorate.id == _governorate.id,
                    ),
                    entries: (sl<AppSettings>().governorates),
                    toLabel: (value) {
                      return value?.name ?? "غير محدد";
                    },
                    onSelected: (entry) {
                      _governorate = entry!;
                    },
                  ),
                  // const SizedBox(height: SpacesResources.s5),
                  // DropDownWidget<Section>(
                  //   hintText: "الفرع الدراسي",
                  //   initialSelection: sl<AppSettings>().sections.firstWhere(
                  //     (section) => section.id == _section.id,
                  //   ),
                  //   entries: (sl<AppSettings>().sections),
                  //   toLabel: (value) {
                  //     return value?.name ?? "غير محدد";
                  //   },
                  //   onSelected: (entry) {
                  //     _section = entry!;
                  //   },
                  // ),
                  const SizedBox(height: SpacesResources.s20),
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
                            : Text("انشاء حساب"),
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
