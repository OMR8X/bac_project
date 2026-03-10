import 'package:neuro_app/core/resources/errors/failures.dart';
import 'package:neuro_app/core/widgets/ui/fields/elevated_button_widget.dart';
import 'package:flutter/cupertino.dart';

class FailureWidget extends StatelessWidget {
  const FailureWidget({super.key, this.failure, required this.onReTry});
  final Failure? failure;
  final VoidCallback onReTry;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text((failure ?? const UnknownFailure()).message),
          ElevatedButtonWidget(title: "اعادة المحاولة", onPressed: onReTry),
        ],
      ),
    );
  }
}
