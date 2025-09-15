// import 'dart:math';

// import 'package:bac_project/core/helpers/input_validator.dart';
// import 'package:bac_project/core/injector/app_injection.dart';
// import 'package:bac_project/core/resources/styles/font_styles_manager.dart';
// import 'package:bac_project/core/resources/styles/padding_resources.dart';
// import 'package:bac_project/core/resources/styles/spaces_resources.dart';
// import 'package:bac_project/core/widgets/ui/fields/text_form_field_widget.dart';
// import 'package:bac_project/features/managers/domain/usecases/reports/create_report_usecase.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import '../../../features/managers/domain/entities/report.dart';
// import '../../../features/managers/domain/requests/create_entity_request.dart';
// import '../../resources/styles/decoration_resources.dart';
// import '../../resources/styles/sizes_resources.dart';
// import '../../resources/themes/extensions/surface_container_colors.dart';
// import '../ui/fields/text_button_widget.dart';

// showReportFileDialog({required BuildContext context, required String fileId, required String userId}) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     isDismissible: false,
//     builder: (context) {
//       return Container(decoration: DecorationResources.inputDialogDecoration(theme: Theme.of(context)), child: Padding(padding: const EdgeInsets.symmetric(vertical: 10.0), child: SizedBox(child: _ReportFileDialog(fileId: fileId, userId: userId))));
//     },
//   );
// }

// class _ReportFileDialog extends StatefulWidget {
//   const _ReportFileDialog({super.key, required this.fileId, required this.userId});

//   final String fileId;
//   final String userId;

//   @override
//   State<_ReportFileDialog> createState() => __ReportFileDialogState();
// }

// class __ReportFileDialogState extends State<_ReportFileDialog> {
//   ///
//   late bool _isLoading;

//   ///
//   late final TextEditingController _textController;

//   ///
//   @override
//   void initState() {
//     _isLoading = false;
//     _textController = TextEditingController();

//     super.initState();
//   }

//   onReport() async {
//     //
//     setState(() => _isLoading = true);
//     //
//     final request = CreateEntityRequest<Report>(entity: Report(id: "0", fileId: widget.fileId, userId: widget.userId, description: _textController.text, createdDate: DateTime.timestamp()));
//     //
//     final response = await sl<CreateReportUsecase>().call(request: request);
//     //
//     response.fold(
//       (l) {
//         Fluttertoast.showToast(msg: l.message);
//       },
//       (r) {
//         Fluttertoast.showToast(msg: r.message);
//         Navigator.of(context).pop();
//       },
//     );
//     //
//     setState(() => _isLoading = false);
//     //
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.only(
//               bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for the keyboard
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 const SizedBox(height: SpacesResources.s10),
//                 Text("الابلاغ عن ملف", style: FontStylesResources.appBarButtonStyle),
//                 const SizedBox(height: SpacesResources.s10),
//                 TextFormFieldWidget(
//                   hintText: "تفاصيل الابلاغ",
//                   controller: _textController,
//                   maxLines: null,
//                   textInputAction: TextInputAction.newline,
//                   validator: (p0) {
//                     return InputValidator.notEmptyValidator(p0);
//                   },
//                 ),
//                 const SizedBox(height: SpacesResources.s2),
//                 SizedBox(width: SizesResources.mainWidth(context), child: Text("سوف يتم مراجعة الابلاغ والرد عليه في أقرب وقت ممكن", style: FontStylesResources.underButtonStyle)),
//                 const SizedBox(height: SpacesResources.s5),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     TextButtonWidget(
//                       width: SizesResources.mainHalfWidth(context),
//                       textColor: Theme.of(context).colorScheme.onSurface,
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       title: 'الغاء',
//                     ),
//                     TextButtonWidget(
//                       loading: _isLoading,
//                       width: SizesResources.mainHalfWidth(context),
//                       onPressed: () {
//                         onReport();
//                       },
//                       title: 'ابلاغ',
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: MediaQuery.of(context).padding.bottom),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
