import 'package:flutter/material.dart';
import '../../../resources/styles/font_styles_manager.dart';
import '../../../resources/styles/padding_resources.dart';
import '../../../resources/styles/sizes_resources.dart';
import '../../animations/staggered_item_wrapper_widget.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.hintText,
    this.initialValue,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.onFieldSubmitted,
    this.controller,
    this.obscureText = false,
    this.textInputAction,
    this.maxLength,
    this.maxLines = 1,
    this.position = 1,
    this.keyboardType,
  });
  //
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  //
  final String hintText;
  final String? initialValue;
  //
  final int position;
  final int? maxLength;
  final int? maxLines;
  //
  final bool obscureText;
  //
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  //
  final String? Function(String?)? validator;
  //
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: PaddingResources.padding_0_4,
      width: SizesResources.mainWidth(context),
      child: StaggeredItemWrapperWidget(
        position: position,
        child: TextFormField(
          initialValue: initialValue,
          controller: controller,
          validator: validator,
          obscureText: obscureText && obscureText,
          textInputAction: textInputAction ?? TextInputAction.next,
          onSaved: onSaved,
          maxLines: maxLines,
          keyboardType: keyboardType,
          maxLength: maxLength,
          onChanged: onChanged,
          style: FontStylesResources.textFieldStyle,
          onFieldSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            hintText: " $hintText",
            hintStyle: const TextStyle(
              fontWeight: FontWeightResources.regular,
            ),
          ),
        ),
      ),
    );
  }
}
