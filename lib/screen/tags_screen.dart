import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timebloc/base_view/base_list_view.dart';
import 'package:timebloc/provider/tags_provider.dart';
import 'package:timebloc/screen/add_event_types_screen.dart';
import 'package:timebloc/screen/add_route_screen.dart';
import 'package:timebloc/screen/add_tag_screen.dart';
import 'package:timebloc/utils/color_resources.dart';
import 'package:timebloc/utils/dimensions.dart';
import 'package:timebloc/utils/utils.dart';
import 'package:timebloc/views/add_event_item.dart';
import 'package:timebloc/views/custom_button.dart';
import 'package:timebloc/views/route_item.dart';
import 'package:timebloc/views/tag_item.dart';

import '../model/tag.dart';
import '../utils/custom_style.dart';
import '../views/icon_decoration.dart';

class TagsScreen extends StatefulWidget {
  TagsScreen({super.key});

  @override
  State<TagsScreen> createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
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
                            InkWell(
                                child: DecoratedIcon(Icons.arrow_back),
                                onTap: () {
                                  popWidget(context);
                                }),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Tags",
                                    style: titleHeaderExtra.copyWith(
                                        fontSize: Dimensions
                                            .FONT_SIZE_EXTRA_EXTRA_LARGE,
                                        color: getTitleColor(context,opacity: 1)),
                                  ),
                                  Text(
                                    "Settings",
                                    style: titleRegular.copyWith(
                                        color: getTitleColor(context,opacity: 1)),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getHeightMargin(context, 3),
                      ),
                      Consumer<TagsProvider>(
                        builder: (context, provider, child) {
                          return BaseListView<Tag>(provider.tags,
                              baseListWidgetBuilder: (data, pos) {
                            return TagItem(tag: data!);
                          }, scrollable: false, shrinkable: true);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: getWidthMargin(context, 20),
                  vertical: Dimensions.MARGIN_SIZE_SMALL),
              child: CustomButton(
                  onTap: () {
                    startNewScreenWithRoot(context, AddTagScreen(), true);
                  },
                  buttonText: "Add New Tag",
                  backgroundColor: ColorResources.getPrimaryColor()),
            )
          ],
        ),
      ),
    );
  }
}
