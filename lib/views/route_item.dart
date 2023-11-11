import 'package:flutter/material.dart';
import 'package:timebloc/base_view/base_list_view.dart';
import 'package:timebloc/init_app.dart';
import 'package:timebloc/model/event.dart';
import 'package:timebloc/screen/add_route_screen.dart';
import 'package:timebloc/utils/color_resources.dart';
import 'package:timebloc/utils/custom_style.dart';
import 'package:timebloc/utils/utils.dart';
import 'package:timebloc/views/image_decoration.dart';
import 'package:timebloc/views/imoji_decoration.dart';

import '../model/routine.dart';
import '../utils/dimensions.dart';

class RouteItem extends StatefulWidget {
  Routine routine;

  RouteItem({super.key, required this.routine});

  @override
  State<RouteItem> createState() => _RouteItemState();
}

class _RouteItemState extends State<RouteItem> {
  bool selected = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
    selected = widget.routine.isEnabled;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        startNewScreenWithRoot(
            context, AddRouteScreen(routine: widget.routine), true);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: getHeightMargin(context, 1)),
        decoration: BoxDecoration(
            color:Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: ColorResources.DARK_GREY.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: const Offset(0, 1))
            ]),
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.routine.name,
                          style: titleRegular.copyWith(
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                              color: getTitleColor(context, opacity: 1)),
                        ),
                        widget.routine.events.isNotEmpty
                            ? const SizedBox.shrink()
                            : Text(
                                "Not Event Added",
                                style: titleRegular.copyWith(
                                    color:
                                        getTitleColor(context, opacity: 0.2)),
                              ),
                      ],
                    ),
                  ),
                  Switch.adaptive(
                      value: selected,
                      onChanged: (value) {
                        widget.routine.isEnabled = value;
                        timeBlockDatabase.routineDao
                            .updateRoutie(widget.routine);
                        setState(() {
                          selected = value;
                        });
                      })
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              widget.routine.events.isEmpty
                  ? const SizedBox.shrink()
                  : SizedBox(
                      height: 50,
                      child: BaseListView<Event>(
                        widget.routine.events,
                        axis: Axis.horizontal,
                        baseListWidgetBuilder: (data, pos) {
                          return Container(
                            margin: const EdgeInsets.only(right: 4),
                            child: data!.isImageImojie
                                ? DecoratedEmoji(
                                    data.image,
                                    backgroundColor: data.color,
                                    size: 20,
                                    radius: 20,
                                  )
                                : DecoratedImage(
                                    data!.image,
                                    isColorFull: true,
                                    backgroundColor: data.color,
                                    radius: 20,
                                    height: 20,
                                    width: 20,
                                  ),
                          );
                        },
                        scrollable: true,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
