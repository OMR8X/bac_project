import 'package:bac_project/core/resources/styles/sizes_resources.dart';
import 'package:flutter/material.dart';

class DropdownButtonWidget extends StatefulWidget {
  const DropdownButtonWidget({super.key, this.value, required this.list, this.title, required this.onSave});

  final String? value, title;
  final List<String> list;
  final Function(String?) onSave;

  @override
  State<DropdownButtonWidget> createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  late String selectedValue;
  @override
  void initState() {
    if (widget.list.contains(widget.value) && widget.value != null) {
      selectedValue = widget.value!;
    } else {
      selectedValue = widget.list.first;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        width: SizesResources.mainWidth(context),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(19),
          child: Material(
            color: themeData.primaryColorDark,
            borderRadius: BorderRadius.circular(19),
            child: DropdownButtonFormField(
              elevation: 0,
              onChanged: onChange,
              onSaved: onSave,
              hint: Text(widget.title == null ? selectedValue : "${widget.title} : $selectedValue", style: themeData.textTheme.labelMedium),
              dropdownColor: themeData.primaryColorDark,
              focusColor: themeData.primaryColorDark,
              items: itemsBuilder(themeData),
              decoration: getDecoration(themeData),
            ),
          ),
        ),
      ),
    );
  }

  onChange(String? value) {
    selectedValue = value as String;

    setState(() {});
  }

  onSave(String? value) {
    widget.onSave(value ?? widget.list.first);
  }

  List<DropdownMenuItem<String>>? itemsBuilder(ThemeData themeData) {
    List<DropdownMenuItem<String>>? list = widget.list.map((e) => DropdownMenuItem(value: e, child: Text(widget.title == null ? e : "${widget.title} : $e", style: themeData.textTheme.labelMedium))).toList();
    return list;
  }
}

getDecoration(ThemeData themeData) {
  return InputDecoration(
    errorStyle: themeData.textTheme.labelMedium!.copyWith(color: const Color(0xffD93D2D)),
    hintStyle: themeData.textTheme.labelLarge!,
    errorBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(0.0)), borderSide: BorderSide(width: 3, color: Color(0xffD93D2D))),
    border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(0.0)), borderSide: BorderSide(width: 1, color: themeData.primaryColorDark)),
    focusedBorder: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(0.0)), borderSide: BorderSide(width: 2, color: themeData.primaryColor)),
    enabledBorder: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(0.0)), borderSide: BorderSide(width: 1, color: themeData.primaryColorDark)),
  );
}
