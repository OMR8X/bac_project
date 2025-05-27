// import 'package:bac_project/core/injector/app_injection.dart';
// import 'package:bac_project/features/auth/domain/entites/user_data.dart';
// import 'package:bac_project/features/auth/domain/requests/get_user_data_request.dart';
// import 'package:bac_project/features/auth/domain/usecases/get_user_data_usecase.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:go_router/go_router.dart';

// class UserProfileView extends StatefulWidget {
//   const UserProfileView({super.key, required this.userId});
//   final String userId;
//   @override
//   State<UserProfileView> createState() => _UserProfileViewState();
// }

// class _UserProfileViewState extends State<UserProfileView> {
//   ///
//   late bool _isLoading;
//   late final UserData _userData;

//   ///
//   @override
//   void initState() {
//     _isLoading = true;
//     loadUserData();
//     super.initState();
//   }

//   ///
//   Future<void> loadUserData() async {
//     //
//     final GetUserDataRequest request = GetUserDataRequest(userId: widget.userId);
//     //
//     final response = await sl<GetUserDataUseCase>().call(request: request);
//     //
//     response.fold(
//       (l) {
//         Fluttertoast.showToast(msg: l.message);
//         context.pop();
//       },
//       (r) {
//         _userData = r.user;
//         setState(() {
//           _isLoading = false;
//         });
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return const Center(child: CupertinoActivityIndicator());
//     }
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Column(
//           children: [
//             Text(_userData.id, style: const TextStyle(fontSize: 24)),
//             Text(_userData.name, style: const TextStyle(fontSize: 24)),
//             Text(_userData.email, style: const TextStyle(fontSize: 18)),
//             Text(_userData.accountType, style: const TextStyle(fontSize: 18)),
//           ],
//         ),
//       ),
//     );
//   }
// }
