import 'package:flutter/cupertino.dart';
import 'package:timebloc/utils/utils.dart';

typedef BaseListWidgetBuilder<T> = Widget Function(T data, int pos);

typedef BaseListSeparatorBuilder = Widget Function(
    BuildContext context, int index);

class BaseListView<T> extends StatelessWidget {
  List<T?> list;
  bool shrinkable;
  bool scrollable;
  Axis axis;

  BaseListWidgetBuilder<T?> baseListWidgetBuilder;
  BaseListSeparatorBuilder? baseListSeparatorBuilder;

  BaseListView(this.list,
      {required this.baseListWidgetBuilder,
        this.axis = Axis.vertical,
      this.baseListSeparatorBuilder,
      this.shrinkable = false,
      required this.scrollable});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: isScrollable()
          ? getBouncingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      shrinkWrap: isShrinkWrap(),
      itemCount: list.length,
      scrollDirection: axis,
      itemBuilder: (context, index) {
        return baseListWidgetBuilder(list[index], index);
      },
      separatorBuilder: (context, index) {
        if (baseListSeparatorBuilder == null) {
          return const SizedBox.shrink();
        }
        return baseListSeparatorBuilder!(context, index);
      },
    );
  }

  bool isShrinkWrap() {
    return shrinkable;
  }

  bool isScrollable() {
    return scrollable;
  }

// Widget getListWidget(BuildContext context, T data);
}
