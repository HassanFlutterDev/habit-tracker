import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:timebloc/views/imoji_decoration.dart';

import '../utils/MyImages.dart';
import '../utils/color_resources.dart';
import '../utils/custom_style.dart';
import '../utils/dimensions.dart';
import '../utils/utils.dart';
import 'icon_decoration.dart';
import 'image_decoration.dart';

typedef ImojiPickerCallback = Function(String imoji, bool isImoji);

class ImojiPickerWidget extends StatefulWidget {
  String image;
  bool isImoji;

  ImojiPickerCallback imojiPickerCallback;

  ImojiPickerWidget(
      {required this.image,
      required this.isImoji,
      required this.imojiPickerCallback});

  @override
  State<ImojiPickerWidget> createState() => _ImojiPickerWidgetState();
}

class _ImojiPickerWidgetState extends State<ImojiPickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Dimensions.MARGIN_SIZE_LARGE),
              topRight: Radius.circular(Dimensions.MARGIN_SIZE_LARGE))),
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
                      "Select Image",
                      style: titleHeaderExtra.copyWith(
                          color: isDarkMode(context)
                              ? ColorResources.WHITE
                              : ColorResources.DARK_GREY),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  widget.imojiPickerCallback(widget.image, widget.isImoji);
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
          widget.isImoji
              ? DecoratedEmoji(widget.image)
              : DecoratedImage(
                  openBookIcon,
                  isColorFull: true,
                  // backgroundColor: widget.selected,
                  width: 50,
                  height: 50,
                ),
          SizedBox(
            height: getHeightMargin(context, 4),
          ),
          Expanded(
            // height: getHeightMargin(context, 30),
            child: EmojiPicker(
              onEmojiSelected: (category, emoji) {
                print(emoji.emoji);

                setState(() {
                  widget.isImoji = true;
                  widget.image = emoji.emoji;
                });

                // setState(() {
                //   selected = emoji.emoji;
                // });
              },
              onBackspacePressed: () {
                // Do something when the user taps the backspace button (optional)
                // Set it to null to hide the Backspace-Button
              },
              textEditingController: TextEditingController(),
              // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
              config: Config(
                columns: 7,
                emojiSizeMax: 32 * (1.0),
                verticalSpacing: 0,
                horizontalSpacing: 0,
                gridPadding: EdgeInsets.zero,
                initCategory: Category.RECENT,
                bgColor: Theme.of(context).cardColor,
                indicatorColor: Colors.blue,
                iconColor: Colors.grey,
                iconColorSelected: Colors.blue,
                backspaceColor: Colors.blue,
                skinToneDialogBgColor: Colors.white,
                skinToneIndicatorColor: Colors.grey,
                enableSkinTones: true,
                recentTabBehavior: RecentTabBehavior.RECENT,
                recentsLimit: 28,
                noRecents: Text(
                  'No Recents',
                  style: TextStyle(fontSize: 20, color: getTitleColor(context)),
                  textAlign: TextAlign.center,
                ),
                // Needs to be const Widget
                loadingIndicator: const SizedBox.shrink(),
                // Needs to be const Widget
                tabIndicatorAnimDuration: kTabScrollDuration,
                categoryIcons: const CategoryIcons(),
                buttonMode: ButtonMode.MATERIAL,
              ),
            ),
          )
        ],
      ),
    );
  }
}
