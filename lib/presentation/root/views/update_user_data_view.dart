// import 'dart:math';

// import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// import '../../core/helpers/input_validator.dart';
// import '../../core/injector/app_injection.dart';
// import '../../core/resources/styles/spaces_resources.dart';
// import '../../core/resources/themes/extensions/surface_container_colors.dart';
// import '../../core/widgets/ui/fields/drop_down_widget.dart';
// import '../../core/widgets/ui/fields/elevated_button_widget.dart';
// import '../../core/widgets/ui/fields/text_form_field_widget.dart';
// import '../../features/auth/domain/entites/user_data.dart';
// import '../../features/managers/domain/entities/app_managers.dart';
// import '../../features/managers/domain/entities/file_section.dart';
// import '../../features/managers/domain/entities/governorate.dart';
// import 'state/bloc/auth_bloc.dart';

// class UpdateUserDataView extends StatefulWidget {
//   const UpdateUserDataView({super.key});

//   @override
//   State<UpdateUserDataView> createState() => _UpdateUserDataViewState();
// }

// class _UpdateUserDataViewState extends State<UpdateUserDataView> {
//   //
//   late bool _didFillInfo = false;
//   //
//   late final GlobalKey<FormState> _formKey;
//   //
//   late final TextEditingController _nameController;
//   late final TextEditingController _emailController;
//   late final TextEditingController _passwordController;
//   late final TextEditingController _confirmPasswordController;
//   //
//   late FileSection _section;
//   late Governorate _governorate;
//   //
//   @override
//   void initState() {
//     //
//     _didFillInfo = false;
//     //
//     _formKey = GlobalKey<FormState>();
//     //
//     _nameController = TextEditingController();
//     _emailController = TextEditingController();
//     _passwordController = TextEditingController();
//     _confirmPasswordController = TextEditingController();
//     //
//     //
//     _section = sl<AppManagers>().sections.first;
//     _governorate = sl<AppManagers>().governorates.first;
//     //
//     initListeners();
//     //
//     super.initState();
//   }

//   initListeners() {
//     _nameController.addListener(_updateButtonState);
//     _emailController.addListener(_updateButtonState);
//     _passwordController.addListener(_updateButtonState);
//     _confirmPasswordController.addListener(_updateButtonState);
//   }

//   void _updateButtonState() {
//     //
//     _didFillInfo = _nameController.text.isNotEmpty || _emailController.text.isNotEmpty || _passwordController.text.isNotEmpty || _confirmPasswordController.text.isNotEmpty;

//     //
//     if (!_didFillInfo && _section.id == sl<UserData>().sectionId && _governorate.id == sl<UserData>().governorateId) {
//       _didFillInfo = false;
//     }

//     //
//     setState(() {});
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   void _submit() async {
//     //
//     String? name = _nameController.text.isNotEmpty ? _nameController.text : null;
//     String? email = _emailController.text.isNotEmpty ? _emailController.text : null;
//     String? password = _passwordController.text.isNotEmpty ? _passwordController.text : null;
//     //
//     sl<AuthBloc>().add(AuthUpdateUserDataEvent(name: name, email: email, governorateId: _governorate.id, sectionId: _section.id, password: password));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("تغيير بيانات الحساب"),
//         leading: IconButton(
//           onPressed: () {
//             context.pop();
//           },
//           icon: const Icon(Icons.close, size: 20),
//         ),
//       ),
//       body: SafeArea(
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 const SizedBox(height: SpacesResources.s10),
//                 TextFormFieldWidget(
//                   hintText: "الاسم",
//                   position: 1,
//                   keyboardType: TextInputType.name,
//                   maxLength: 64,
//                   controller: _nameController,
//                   validator: (text) {
//                     if (text?.isEmpty ?? true) return null;
//                     return InputValidator.nameValidator(text);
//                   },
//                 ),
//                 TextFormFieldWidget(
//                   hintText: "البريد الإلكتروني",
//                   maxLength: 64,
//                   position: 2,
//                   keyboardType: TextInputType.emailAddress,
//                   controller: _emailController,
//                   validator: (text) {
//                     if (text?.isEmpty ?? true) return null;
//                     return InputValidator.emailValidator(text);
//                   },
//                 ),
//                 TextFormFieldWidget(
//                   hintText: "كلمة المرور",
//                   maxLength: 64,
//                   position: 3,
//                   obscureText: true,
//                   keyboardType: TextInputType.visiblePassword,
//                   controller: _passwordController,
//                   validator: (text) {
//                     if (text?.isEmpty ?? true) return null;
//                     return InputValidator.passwordValidator(text);
//                   },
//                 ),
//                 TextFormFieldWidget(
//                   hintText: "تاكيد كلمة المرور",
//                   maxLength: 64,
//                   position: 4,
//                   obscureText: true,
//                   keyboardType: TextInputType.visiblePassword,
//                   controller: _confirmPasswordController,
//                   validator: (text) {
//                     if (_passwordController.text != _confirmPasswordController.text) {
//                       return "كلمة المرور غير متطابقة";
//                     }
//                     if (text?.isEmpty ?? true) return null;
//                     return InputValidator.passwordValidator(text);
//                   },
//                 ),
//                 DropDownWidget<Governorate>(
//                   hintText: "المحافظة",
//                   initialSelection: sl<AppManagers>().governorateById(id: sl<UserData>().governorateId, nullable: true),
//                   entries: (sl<AppManagers>().governorates),
//                   toLabel: (value) {
//                     return value?.name ?? "غير محدد";
//                   },
//                   onSelected: (entry) {
//                     //
//                     _governorate = entry!;
//                     //
//                     if (entry.id != sl<UserData>().governorateId) {
//                       setState(() => _didFillInfo = true);
//                       return;
//                     }
//                     //
//                     if (_nameController.text.isEmpty && _emailController.text.isEmpty) {
//                       if (_passwordController.text.isEmpty && _confirmPasswordController.text.isEmpty) {
//                         if (_section.id == sl<UserData>().sectionId) {
//                           setState(() => _didFillInfo = false);
//                         }
//                       }
//                     }
//                   },
//                 ),
//                 DropDownWidget<FileSection>(
//                   hintText: "الفرع الدراسي",
//                   initialSelection: sl<AppManagers>().sectionById(id: sl<UserData>().sectionId, nullable: true),
//                   entries: (sl<AppManagers>().sections),
//                   toLabel: (value) {
//                     return value?.name ?? "غير محدد";
//                   },
//                   onSelected: (entry) {
//                     //
//                     _section = entry!;
//                     //
//                     if (entry.id != sl<UserData>().sectionId) {
//                       setState(() => _didFillInfo = true);
//                       return;
//                     }
//                     //
//                     if (_nameController.text.isEmpty && _emailController.text.isEmpty) {
//                       if (_passwordController.text.isEmpty && _confirmPasswordController.text.isEmpty) {
//                         if (_governorate.id == sl<UserData>().governorateId) {
//                           setState(() => _didFillInfo = false);
//                         }
//                       }
//                     }
//                   },
//                 ),
//                 BlocProvider.value(
//                   value: sl<AuthBloc>(),
//                   child: BlocBuilder<AuthBloc, AuthState>(
//                     builder: (context, state) {
//                       return ElevatedButtonWidget(
//                         title: "تغيير البيانات",
//                         loading: state.loading,
//                         position: 5,
//                         backgroundColor: Theme.of(context).extension<SurfaceContainerColors>()!.surfaceContainer,
//                         onPressed:
//                             _didFillInfo
//                                 ? () {
//                                   if (_formKey.currentState?.validate() ?? false) {
//                                     _submit();
//                                   }
//                                 }
//                                 : null,
//                       );
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: SpacesResources.s2),
//                 const Text("اترك اي حقل لا ترغب بتغييره فارغ", style: FontStylesResources.underButtonStyle),
//                 const SizedBox(height: SpacesResources.s20),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
