import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:timebloc/init_app.dart';
import 'package:timebloc/model/event.dart';
import 'package:timebloc/my_notification.dart';
import 'package:timebloc/payment_api.dart';
import 'package:timebloc/provider/events_provider.dart';
import 'package:timebloc/provider/routines_provider.dart';
import 'package:timebloc/provider/tags_provider.dart';
import 'package:timebloc/provider/theme_provider.dart';
import 'package:timebloc/screen/home_screen.dart';
import 'package:timebloc/screen/landing_screen.dart';
import 'package:timebloc/screen/payment_screen.dart';
import 'package:timebloc/screen/routines_screen.dart';
import 'package:timebloc/screen/settings_screen.dart';
import 'package:timebloc/screen/stats_screen.dart';
import 'package:timebloc/utils/MyImages.dart';
import 'package:timebloc/utils/color_resources.dart';
import 'package:timebloc/utils/utils.dart';

import 'model/nav_model.dart';
import 'package:cron/cron.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PurchaseApi.init();
  GetStorage.init();
  await initApp();
  MyNotification.initialize(flutterLocalNotificationsPlugin);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => TagsProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => EventsProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => RoutinesProvider(),
      ),
    ],
    child: const MyApp(),
  ));

  final cron = Cron();

  // showTextNotification(
  //     "New Event ", "New Event Added", flutterLocalNotificationsPlugin);
  cron.schedule(Schedule.parse('*/1 * * * *'), () async {
    List<Event> events = await timeBlockDatabase.eventDao
        .findAllEventsByDate(getFormattedDate(DateTime.now()));
    for (Event event in events) {
      String formattedEventStartTime = getFormattedTime(event.startTime);
      String formattedEventEndTime = getFormattedTime(event.endTime);
      String currentTime = getCurrentTime();
      if (formattedEventStartTime == currentTime) {
        showTextNotification(
            "Event Started", event.name, flutterLocalNotificationsPlugin);
      } else if (formattedEventEndTime == currentTime) {
        showTextNotification(
            "Event Finished", event.name, flutterLocalNotificationsPlugin);
      }
    }
  });
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var box = GetStorage();
    return Consumer<ThemeProvider>(
      builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          title: 'Habit Tracker',
          theme: value.newTheme,
          themeMode: value.isDark ? ThemeMode.dark : ThemeMode.light,
          darkTheme: value.darkTheme,
          home: box.read('land') == null
              ? LandingScreen()
              : PurchaseApi.isPaid
                  ? MainWidget()
                  : PaymentScreen(),
        );
      },
    );
  }
}

class MainWidget extends StatefulWidget {
  const MainWidget({
    super.key,
  });

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  final PageController _pageController = PageController();
  int _pageIndex = 0;
  final List<Widget> _screens = [];
  List<Widget> bottomNavBars = [];
  List<BottomNavModel> bottomNavBarsData = [];

  @override
  void initState() {
    super.initState();

    _screens.add(HomeScreen());
    _screens.add(const RoutinesScreen());
    _screens.add(StatsScreen());
    _screens.add(SettingsScreen());

    Provider.of<TagsProvider>(context, listen: false).getTags();
    Provider.of<EventsProvider>(context, listen: false)
        .setSelectedDateTime(DateTime.now());

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      try {
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()!
            .requestNotificationsPermission();
      } catch (e) {}
    });
  }

  DotNavigationBarItem getBottomNavItem(String image) {
    return DotNavigationBarItem(
      icon: Image.asset(
        image,
        height: 20,
        width: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _pageIndex = 0;
          _pageController.jumpToPage(0);
          setState(() {});
          return false;
        }
        return true;
      },
      child: Scaffold(
        bottomNavigationBar: DotNavigationBar(
          enableFloatingNavBar: false,
          backgroundColor: Theme.of(context).cardColor,
          // curve:  Curves.,
          currentIndex: _pageIndex,
          onTap: (p0) {
            setState(() {
              _pageIndex = p0;
              _pageController.jumpToPage(p0);
            });
          },
          dotIndicatorColor: isDarkMode(context) ? Colors.white : Colors.black,
          // enableFloatingNavBar: false
          items: [
            getBottomNavItem(homeIcon),
            getBottomNavItem(dailyTaskIcon),
            getBottomNavItem(growthIcon),
            getBottomNavItem(settingIcon),
          ],
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
      ),
    );
  }

  Widget getBottomNav({required Function onSelect}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _getBottomWidget(onSelect: onSelect),
        ),
      ],
    );
  }

  List<Widget> _getBottomWidget({required Function onSelect}) {
    bottomNavBarsData = [];
    bottomNavBars = [];
    bottomNavBarsData.add(BottomNavModel(0, "Home", homeIcon, homeIcon));
    bottomNavBarsData.add(BottomNavModel(1, "Home", routesIcon, routesIcon));
    bottomNavBarsData.add(BottomNavModel(2, "Home", graphIcon, graphIcon));
    // bottomNavBarsData.add(BottomNavModel(3, "Home", settingIcon, settingIcon));

    for (BottomNavModel model in bottomNavBarsData) {
      bottomNavBars.add(_barItem(
          model.icon, model.name, bottomNavBarsData.indexOf(model),
          selectedImage: model.selectedIcon, onSelect: onSelect));
    }
    return bottomNavBars;
  }

  Widget _barItem(String icon, String label, int index,
      {bool business = true,
      required Function onSelect,
      required String selectedImage}) {
    return InkWell(
      onTap: () {
        onSelect(index);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Image.asset(
              index == _pageIndex ? selectedImage : icon,
              color: index == _pageIndex
                  ? ColorResources.BLACK
                  : ColorResources.DARK_GREY,
              height: 25,
              width: 25,
            ),
            index == _pageIndex
                ? Image.asset(
                    dotIcon,
                    fit: BoxFit.cover,
                    height: 15,
                    width: 15,
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
