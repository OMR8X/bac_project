import 'package:flutter/cupertino.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SkeletonizerEffectListWrapper extends StatelessWidget {
  const SkeletonizerEffectListWrapper.loading({
    super.key,
    required this.child,
    this.itemCount,
    this.physics,
    this.shrinkWrap = false,
  });
  const SkeletonizerEffectListWrapper.pagination({
    super.key,
    required this.child,
    this.itemCount = 3,
    this.physics = const NeverScrollableScrollPhysics(),
    this.shrinkWrap = true,
  });
  final Widget child;
  final int? itemCount;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: ListView.builder(
        shrinkWrap: shrinkWrap,
        physics: physics,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return child;
        },
      ),
    );
  }
}
