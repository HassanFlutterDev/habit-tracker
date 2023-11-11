import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timebloc/base_view/base_list_view.dart';
import 'package:timebloc/provider/events_provider.dart';
import 'package:timebloc/screen/add_event_types_screen.dart';
import 'package:timebloc/utils/color_resources.dart';
import 'package:timebloc/utils/dimensions.dart';
import 'package:timebloc/utils/utils.dart';
import 'package:timebloc/views/add_event_item.dart';
import 'package:timebloc/views/event_item.dart';

import '../utils/custom_style.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var currentDate = "";
  late EventsProvider eventsProvider;

  String selected = "";

  @override
  void initState() {
    super.initState();
    eventsProvider = Provider.of<EventsProvider>(context, listen: false);
    currentDate = eventsProvider.selectedDate;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      eventsProvider.getEvent();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(

        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Today",
                              style: titleHeaderExtra.copyWith(
                                  color: ColorResources.DARK_GREY),
                            ),
                            Text(
                              currentDate,
                              style: titleRegular,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          startNewScreenWithRoot(context,
                              AddEventTypesScreen(date: currentDate), true);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(
                              Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          decoration: BoxDecoration(
                              color: ColorResources.DARK_GREY.withAlpha(20),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_LARGE,
                ),
                DatePicker(
                  DateTime.now(),
                  dayTextStyle: const TextStyle(
                    color: ColorResources.DARK_GREY,
                    fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                  ),
                  dateTextStyle: const TextStyle(
                      color: ColorResources.DARK_GREY,
                      fontSize: Dimensions.FONT_SIZE_SMALL,
                      fontWeight: FontWeight.bold),
                  monthTextStyle: const TextStyle(
                    color: ColorResources.DARK_GREY,
                    fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                  ),
                  initialSelectedDate: eventsProvider.selectedDateTime,
                  selectionColor: ColorResources.getPrimaryColor(),
                  selectedTextColor: Colors.white,
                  onDateChange: (date) {
                    currentDate = getFormattedDate(date);
                    eventsProvider.setSelectedDateTime(date);
                    eventsProvider.getEvent();
                    setState(() {});
                    // New date selected
                  },
                ),
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_LARGE,
                ),
                Consumer<EventsProvider>(
                  builder: (context, value, child) {
                    return BaseListView(
                      value.events,
                      baseListWidgetBuilder: (data, pos) {
                        return data == null
                            ? InkWell(
                                child: AddEventItem(),
                                onTap: () {
                                  startNewScreenWithRoot(
                                      context,
                                      AddEventTypesScreen(date: currentDate),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
