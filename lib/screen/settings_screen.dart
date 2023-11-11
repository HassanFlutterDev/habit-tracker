import 'package:flutter/material.dart';
import 'package:timebloc/screen/general_screen.dart';
import 'package:timebloc/screen/tags_screen.dart';
import 'package:timebloc/screen/theme_screen.dart';
import 'package:timebloc/utils/utils.dart';
import 'package:timebloc/views/setting_action.dart';
import 'package:timebloc/views/setting_decorated_container.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/color_resources.dart';
import '../utils/custom_style.dart';
import '../utils/dimensions.dart';
import '../views/icon_decoration.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: getBouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_LARGE,
                ),
                Text(
                  "Settings",
                  style: titleHeaderExtra.copyWith(
                      color: getTitleColor(context), fontSize: 40),
                ),
                SizedBox(
                  height: getHeightMargin(context, 5),
                ),
                // Text(
                //   "PREMIUM",
                //   style: titleHeaderExtra.copyWith(
                //     color: getTitleColor(context),
                //   ),
                // ),
                // const SizedBox(
                //   height: Dimensions.MARGIN_SIZE_DEFAULT,
                // ),
                // SettingDecoratedContainer(
                //     child: Column(
                //   children: [
                //     SettingActionWidget(
                //         title: "Copy Purchase ID", icon: Icons.person),
                //     SizedBox(
                //       height: getHeightMargin(context, 2),
                //     ),
                //     SettingActionWidget(
                //         title: "Restore Purchase ID", icon: Icons.restart_alt),
                //   ],
                // )),
                // SizedBox(
                //   height: getHeightMargin(context, 5),
                // ),
                Text(
                  "APP SETTING",
                  style: titleHeaderExtra.copyWith(
                    color: getTitleColor(context),
                  ),
                ),
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                ),
                SettingDecoratedContainer(
                    child: Column(
                  children: [
                    SettingActionWidget(
                        title: "General",
                        icon: Icons.person,
                        onClick: () {
                          startNewScreenWithRoot(
                              context, GeneralScreen(), true);
                        }),
                    SizedBox(
                      height: getHeightMargin(context, 2),
                    ),
                    SettingActionWidget(
                        title: "Tags",
                        icon: Icons.restart_alt,
                        onClick: () {
                          startNewScreenWithRoot(context, TagsScreen(), true);
                        }),
                    SizedBox(
                      height: getHeightMargin(context, 2),
                    ),
                    SettingActionWidget(
                        title: "Theming",
                        icon: Icons.style,
                        onClick: () {
                          startNewScreenWithRoot(context, ThemeScreen(), true);
                        }),
                    // SizedBox(
                    //   height: getHeightMargin(context, 2),
                    // ),
                    // SettingActionWidget(title: "Reminders", icon: Icons.alarm),
                  ],
                )),
                SizedBox(
                  height: getHeightMargin(context, 5),
                ),
                Text(
                  "Privacy Policy",
                  style: titleHeaderExtra.copyWith(
                    color: getTitleColor(context),
                  ),
                ),
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                ),
                SettingDecoratedContainer(
                    child: Column(
                  children: [
                    // SettingActionWidget(
                    //     title: "Rate TimeBloc 5 Star", icon: Icons.star),
                    // SizedBox(
                    //   height: getHeightMargin(context, 2),
                    // ),
                    // SettingActionWidget(
                    //     title: "Share with a friend", icon: Icons.share),
                    // SizedBox(
                    //   height: getHeightMargin(context, 2),
                    // ),
                    // SettingActionWidget(title: "More Apps", icon: Icons.more),
                    // SizedBox(
                    //   height: getHeightMargin(context, 2),
                    // ),
                    // SettingActionWidget(
                    //     title: "Contact Support",
                    //     icon: Icons.contact_page_rounded),
                    // SizedBox(
                    //   height: getHeightMargin(context, 2),
                    // ),
                    SettingActionWidget(
                        title: "Privacy Policy",
                        onClick: () async {
                          launchUrl(Uri.parse(
                              "https://doc-hosting.flycricket.io/habit-tracker/6968a431-8ed1-49e1-b161-f4414bf6c053/privacy"));
                        },
                        icon: Icons.shield),
                  ],
                )),
                SizedBox(
                  height: getHeightMargin(context, 2),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
