import 'package:flutter/material.dart';
import 'package:timebloc/utils/MyImages.dart';
import 'package:timebloc/utils/dimensions.dart';
import 'package:timebloc/utils/utils.dart';
import 'package:timebloc/views/custom_button.dart';
import 'package:timebloc/views/custom_text_field.dart';
import 'package:timebloc/views/default_event_types.dart';
import 'package:timebloc/views/icon_decoration.dart';
import 'package:timebloc/views/image_decoration.dart';

import '../utils/color_resources.dart';
import '../utils/custom_style.dart';
import 'add_event_screen.dart';

class AddEventTypesScreen extends StatelessWidget {
  String date;
  AddEventTypesScreen({super.key, required this.date});

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
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
                                    "New Event",
                                    style: titleHeaderExtra.copyWith(
                                        color:
                                            getTitleColor(context, opacity: 1)),
                                  ),
                                ),
                              ),
                            ),
                            // DecoratedImage(checkMarkIcon),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_LARGE,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Theme.of(context).cardColor,
                                      width: 10)),
                              child:
                                  DecoratedImage(laptopIcon, isColorFull: true),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: Dimensions.PADDING_SIZE_SMALL),
                                child: CustomTextField(
                                  hintText: "Event Name...",
                                  textEditingController: textEditingController,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getHeightMargin(context, 2),
                      ),
                      Stack(
                        children: [
                          SizedBox(
                            height: getHeightMargin(context, 5),
                          ),
                          Positioned(
                            // top: -2,
                            child: Opacity(
                              opacity: 0.3,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: getWidthMargin(context, 10)),
                                child: Text(
                                  "Suggested",
                                  style: titleHeaderExtra.copyWith(
                                      fontSize: 30,
                                      color: ColorResources.DARK_GREY),
                                ),
                              ),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(
                                  top: Dimensions.MARGIN_SIZE_DEFAULT),
                              child: DefaultEventTypes(
                                date: date,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: getWidthMargin(context, 20),
                    vertical: Dimensions.MARGIN_SIZE_SMALL),
                child: CustomButton(
                    onTap: () {
                      String name = textEditingController.text.toString();
                      if (name.isEmpty) {
                        return;
                      }
                      startNewScreenWithRoot(
                          context,
                          AddEventScreen(
                            name: name,
                            isImoji: false,
                            date: date,
                            image: emailIcon,
                            selectedTags: [],
                          ),
                          true);
                    },
                    buttonText: "Continue",
                    backgroundColor: ColorResources.getPrimaryColor()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
