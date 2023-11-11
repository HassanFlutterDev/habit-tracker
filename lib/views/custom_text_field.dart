import 'package:flutter/material.dart';
import 'package:timebloc/utils/color_resources.dart';
import 'package:timebloc/utils/dimensions.dart';

import '../utils/custom_style.dart';
import '../utils/utils.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController textEditingController;
  String hintText;

  CustomTextField(
      {super.key, required this.textEditingController, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_SMALL,
          vertical: Dimensions.PADDING_SIZE_SMALL),
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDarkMode(context)
            ? Theme.of(context).cardColor
            : ColorResources.getDecorationColor(),

        borderRadius: BorderRadius.circular(20),
        // boxShadow: [
        //   BoxShadow(
        //       color: Colors.grey.withOpacity(0.3),
        //       spreadRadius: 1,
        //       blurRadius: 3,
        //       offset: const Offset(0, 1)) // changes position of shadow
        // ],
      ),
      child: TextFormField(
        enabled: true,
        controller: textEditingController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        initialValue: null,
        textInputAction: TextInputAction.next,
        cursorColor: ColorResources.DARK_GREY,
        decoration: InputDecoration(
          hintText: hintText ?? '',
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
          isDense: true,
          counterText: '',
          // focusedBorder: OutlineInputBorder(
          //     borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          hintStyle:
              titilliumRegular.copyWith(color: Theme.of(context).hintColor),
          errorStyle: const TextStyle(height: 1.5),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
