import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timebloc/utils/shared_pref_helper.dart';
import 'package:timebloc/utils/utils.dart';
import 'package:timebloc/views/colors_widget.dart';
import 'package:timebloc/views/icon_decoration.dart';

import '../utils/MyImages.dart';
import '../utils/color_resources.dart';
import '../utils/custom_style.dart';
import '../utils/dimensions.dart';
import 'image_decoration.dart';

typedef DurationPickerCallback = Function(String startTime, String endTime);

class CustomDurationPickerBottomSheet extends StatefulWidget {
  String startTime, endTime;
  DurationPickerCallback durationPickerCallback;

  CustomDurationPickerBottomSheet(
      {required this.durationPickerCallback,
      required this.startTime,
      required this.endTime});

  @override
  State<CustomDurationPickerBottomSheet> createState() =>
      _CustomDurationPickerBottomSheetState();
}

class _CustomDurationPickerBottomSheetState
    extends State<CustomDurationPickerBottomSheet> {
  bool user24Format = false;

  @override
  void initState() {
    super.initState();
    user24Format = SharePrefHelper.canUse24Format();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Dimensions.MARGIN_SIZE_LARGE),
              topRight: Radius.circular(Dimensions.MARGIN_SIZE_LARGE))),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
            vertical: Dimensions.MARGIN_SIZE_LARGE),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                InkWell(
                    onTap: () {
                      popWidget(context);
                    },
                    child: DecoratedIcon(Icons.close)),
                Expanded(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(
                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: Text(
                        "Select Time",
                        style: titleHeaderExtra.copyWith(
                            color: ColorResources.DARK_GREY),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // if (widget.selected.isEmpty) {
                    //   return;
                    // }
                    //
                    // widget.colorPickerCallback(widget.selected);
                    widget.durationPickerCallback(
                        widget.startTime, widget.endTime);
                    popWidget(context);
                  },
                  child: DecoratedImage(
                    checkMarkIcon,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getHeightMargin(context, 4),
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: CupertinoDatePicker(
                      initialDateTime: getDateTimeFromTime(widget.startTime),
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: user24Format,
                      onDateTimeChanged: (DateTime newDate) {
                        widget.startTime =
                            getCurrentServerTime(dateTime: newDate);

                        print("End Time" + widget.startTime);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: CupertinoDatePicker(
                      initialDateTime: getDateTimeFromTime(widget.endTime),
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: user24Format,

                      onDateTimeChanged: (DateTime newDate) {
                        widget.endTime =
                            getCurrentServerTime(dateTime: newDate);

                        print("End Time" + widget.endTime);
                        print("End Time" + newDate.hour.toString());
                        print("End Time" + newDate.minute.toString());
                        print("End Time" + newDate.second.toString());
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
