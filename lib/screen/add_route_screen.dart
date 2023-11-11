import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timebloc/base_view/base_list_view.dart';
import 'package:timebloc/provider/events_provider.dart';
import 'package:timebloc/provider/routines_provider.dart';
import 'package:timebloc/utils/MyImages.dart';
import 'package:timebloc/utils/dimensions.dart';
import 'package:timebloc/utils/utils.dart';
import 'package:timebloc/views/add_event_item.dart';
import 'package:timebloc/views/custom_button.dart';
import 'package:timebloc/views/custom_text_field.dart';
import 'package:timebloc/views/day_selection_view.dart';
import 'package:timebloc/views/default_event_types.dart';
import 'package:timebloc/views/event_item.dart';
import 'package:timebloc/views/icon_decoration.dart';
import 'package:timebloc/views/image_decoration.dart';

import '../model/event.dart';
import '../model/routine.dart';
import '../utils/color_resources.dart';
import '../utils/custom_style.dart';
import 'add_event_screen.dart';

class AddRouteScreen extends StatefulWidget {
  Routine? routine;

  AddRouteScreen({super.key, this.routine});

  @override
  State<AddRouteScreen> createState() => _AddRouteScreenState();
}

class _AddRouteScreenState extends State<AddRouteScreen> {
  TextEditingController textEditingController = TextEditingController();

  String selectedDay = "THU";
  bool isShowDeleteButton = false;

  late EventsProvider eventsProvider;

  @override
  void initState() {
    eventsProvider = Provider.of<EventsProvider>(context, listen: false);
    if (widget.routine != null) {
      eventsProvider.setDataForRoutine(widget.routine!.id!, selectedDay);
      eventsProvider.getRoutineEvent();

      isShowDeleteButton = true;
      textEditingController.text = widget.routine!.name;
      textEditingController.addListener(() {
        if (!isShowDeleteButton) {
          return;
        }
        setState(() {
          isShowDeleteButton = false;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: getBouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_LARGE,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                  child: Row(
                    children: [
                      InkWell(
                          child: DecoratedIcon(Icons.close),
                          onTap: () {
                            popWidget(context);
                          }),
                      Expanded(
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(
                                Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: Text(
                              widget.routine == null
                                  ? "Add Routine"
                                  : "Edit Route",
                              style: titleHeaderExtra.copyWith(
                                  color: getTitleColor(context, opacity: 1)),
                            ),
                          ),
                        ),
                      ),
                      isShowDeleteButton
                          ? InkWell(
                              child:
                                  DecoratedIcon(Icons.delete_forever_outlined),
                              onTap: () async{
                               void result = await Provider.of<RoutinesProvider>(context,listen: false).deleteRoutine(widget.routine!);
                               popWidget(context);
                              },
                            )
                          : InkWell(
                              child: DecoratedImage(checkMarkIcon,
                                  height: 20, width: 20),
                              onTap: () {
                                String name =
                                    textEditingController.text.toString();
                                Routine routine = Routine(name: name);
                                Provider.of<RoutinesProvider>(context,
                                        listen: false)
                                    .addRoutine(routine);
                                infoSnackBar(
                                    context, "Routine Add Successfully");
                                popWidget(context);
                              }),
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeightMargin(context, 4),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: Dimensions.PADDING_SIZE_SMALL),
                          child: CustomTextField(
                            hintText: "Route Name...",
                            textEditingController: textEditingController,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeightMargin(context, 3),
                ),
                widget.routine == null
                    ? const SizedBox.shrink()
                    : Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: Dimensions.MARGIN_SIZE_DEFAULT),
                        child: DaySelectionView(
                          selected: selectedDay,
                          onDaySelected: (selected) {
                            setState(() {
                              selectedDay = selected;
                              eventsProvider.setDataForRoutine(
                                  widget.routine!.id!, selectedDay);
                              eventsProvider.getRoutineEvent();
                            });
                          },
                        )),
                SizedBox(
                  height: getHeightMargin(context, 3),
                ),
                widget.routine == null
                    ? const SizedBox.shrink()
                    : Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: Dimensions.MARGIN_SIZE_DEFAULT),
                        child: Consumer<EventsProvider>(
                          builder: (context, provider, child) {
                            return BaseListView<Event>(
                              provider.routineEvents,
                              baseListWidgetBuilder: (data, pos) {
                                return data == null
                                    ? InkWell(
                                        child: AddEventItem(),
                                        onTap: () {
                                          startNewScreenWithRoot(
                                              context,
                                              AddEventScreen(
                                                date: getCurrentDate(),
                                                selectedDays: [],
                                                name: "",
                                                image: emailIcon,
                                                selectedTags: [],
                                                isImoji: false,
                                                routineId: widget.routine!.id,
                                                color: colorList[0],
                                                isRoutineEvent: true,
                                              ),
                                              true);
                                        },
                                      )
                                    : EventItem(event: data);
                              },
                              scrollable: false,
                              shrinkable: true,
                            );
                          },
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
