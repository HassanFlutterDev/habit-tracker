import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timebloc/base_view/base_list_view.dart';
import 'package:timebloc/provider/routines_provider.dart';
import 'package:timebloc/screen/add_route_screen.dart';
import 'package:timebloc/utils/color_resources.dart';
import 'package:timebloc/utils/dimensions.dart';
import 'package:timebloc/utils/utils.dart';
import 'package:timebloc/views/route_item.dart';

import '../model/routine.dart';
import '../utils/custom_style.dart';

class RoutinesScreen extends StatefulWidget {
  const RoutinesScreen({super.key});

  @override
  State<RoutinesScreen> createState() => _RoutinesScreenState();
}

class _RoutinesScreenState extends State<RoutinesScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<RoutinesProvider>(context, listen: false).getRoutines();
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
                              "Routines",
                              style: titleHeaderExtra.copyWith(
                                  color: getTitleColor(context, opacity: 0.5)),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          startNewScreenWithRoot(
                              context, AddRouteScreen(), true);
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
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_LARGE,
                ),
                Consumer<RoutinesProvider>(
                  builder: (context, value, child) {
                    return BaseListView<Routine>(
                      value.routines,
                      baseListWidgetBuilder: (data, pos) {
                        return RouteItem(
                          routine: data!,
                        );
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
