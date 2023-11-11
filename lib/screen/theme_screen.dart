import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timebloc/utils/dimensions.dart';
import 'package:timebloc/utils/utils.dart';
import 'package:timebloc/views/SettingTileWidget.dart';

import '../provider/theme_provider.dart';
import '../utils/custom_style.dart';
import '../views/icon_decoration.dart';

class ThemeScreen extends StatefulWidget {
  ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
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
                                    "Theming",
                                    style: titleHeaderExtra.copyWith(
                                        fontSize: Dimensions
                                            .FONT_SIZE_EXTRA_EXTRA_LARGE,
                                        color:
                                            getTitleColor(context, opacity: 1)),
                                  ),
                                  Text(
                                    "Settings",
                                    style: titleRegular.copyWith(
                                        color:
                                            getTitleColor(context, opacity: 1)),
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
                      SettingTileWidget(
                        title: "Theme",
                        subTitle: "Dark Mode",
                        onClick: (bool value) {
                          Provider.of<ThemeProvider>(context, listen: false)
                              .changeTheme(value);
                        },
                        isChecked: isDarkMode(context),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
