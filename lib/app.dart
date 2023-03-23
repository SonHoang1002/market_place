import 'package:flutter/material.dart';
import 'package:market_place/providers/meProvider.dart';
import 'package:market_place/screens/Auth/storage.dart';
import 'package:market_place/screens/MarketPlace/screen/main_market_page.dart';
import 'package:market_place/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'services/notifications/local_notification.dart';

var routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => const MainMarketPage(),
};

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeManager themeManager = ThemeManager();
  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    getCurrentTheme();
  }

  void getCurrentTheme() async {
    final themeCurrent = await SecureStorage().getKeyStorage('theme');
    themeManager.themeMode = themeCurrent == 'light'
        ? ThemeMode.light
        : themeCurrent == 'dark'
            ? ThemeMode.dark
            : ThemeMode.system;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ThemeManager()),
      ChangeNotifierProvider(create: (_) => MeProvider()),
    ], child: const MaterialAppWithTheme());
  }
}

class MaterialAppWithTheme extends StatefulWidget {
  const MaterialAppWithTheme({
    super.key,
  });

  @override
  State<MaterialAppWithTheme> createState() => _MaterialAppWithThemeState();
}

class _MaterialAppWithThemeState extends State<MaterialAppWithTheme> {
  String? _token;
  String? initialMessage;
  bool _resolved = false;
  late final LocalNotificationService service;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeManager>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: theme.themeMode,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      initialRoute: '/',
      routes: routes,
      navigatorKey: GlobalVariable.navState,
    );
  }
}

class GlobalVariable {
  /// This global key is used in material app for navigation through firebase notifications.
  /// [navState] usage can be found in [notification_notifier.dart] file.
  static final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();
}
