import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timebloc/provider/tags_provider.dart';
import 'package:timebloc/utils/MyImages.dart';
import 'package:timebloc/utils/dimensions.dart';
import 'package:timebloc/utils/utils.dart';
import 'package:timebloc/views/color_picker_bottom_sheet.dart';
import 'package:timebloc/views/colors_widget.dart';
import 'package:timebloc/views/custom_button.dart';
import 'package:timebloc/views/custom_text_field.dart';
import 'package:timebloc/views/horizontal_selection.dart';
import 'package:timebloc/views/icon_decoration.dart';
import 'package:timebloc/views/image_decoration.dart';
import 'package:timebloc/views/imoji_decoration.dart';
import 'package:timebloc/views/imoji_picker_widget.dart';
import 'package:timebloc/views/tag_view.dart';
import 'package:timebloc/views/title_more_text.dart';

import '../model/tag.dart';
import '../utils/color_resources.dart';
import '../utils/custom_style.dart';

class AddTagScreen extends StatefulWidget {
  Tag? tag;

  AddTagScreen({super.key, this.tag});

  @override
  State<AddTagScreen> createState() => _AddTagScreenState();
}

class _AddTagScreenState extends State<AddTagScreen> {
  TextEditingController textEditingController = TextEditingController();

  String selectedColor = "";

  @override
  void initState() {
    super.initState();
    if (widget.tag != null) {
      textEditingController.text = widget.tag!.name;
      selectedColor = widget.tag!.color;
      print("TagId"+widget.tag!.id.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                            widget.tag == null ? "Add New Tag" : "Update Tag",
                            style: titleHeaderExtra.copyWith(
                                color:getTitleColor(context,opacity: 1)),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                        child: DecoratedImage(checkMarkIcon),
                        onTap: () async {
                          if (textEditingController.text.isEmpty) {
                            infoSnackBar(context, "Enter name");
                            return;
                          }
                          if (selectedColor.isEmpty) {
                            infoSnackBar(context, "Select color");

                            return;
                          }
                          Tag tag = Tag(
                              name: textEditingController.text,
                              color: selectedColor);

                          if (widget.tag != null) {
                            tag.id = widget.tag!.id;
                          }

                          bool result = widget.tag == null
                              ? await Provider.of<TagsProvider>(context,
                                      listen: false)
                                  .addTag(tag)
                              : await Provider.of<TagsProvider>(context,
                                      listen: false)
                                  .updateTag(tag);
                          if (result) {
                            // ignore: use_build_context_synchronously
                            infoSnackBar(
                                context,
                                widget.tag == null
                                    ? "Tag Add Successfully"
                                    : "Tag Update Successfully");
                            // ignore: use_build_context_synchronously
                            popWidget(context);
                          } else {
                            // ignore: use_build_context_synchronously
                            infoSnackBar(context, "Something went wrong");
                            return;
                          }
                        }),
                  ],
                ),
              ),
              const SizedBox(
                height: Dimensions.MARGIN_SIZE_LARGE,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                child: CustomTextField(
                  hintText: "Enter Tag  Name...",
                  textEditingController: textEditingController,
                ),
              ),
              SizedBox(
                height: getHeightMargin(context, 5),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.MARGIN_SIZE_DEFAULT),
                child: ColorsWidget(
                  selected: selectedColor,
                  colorPickerCallback: (color) {
                    setState(() {
                      selectedColor = color;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
