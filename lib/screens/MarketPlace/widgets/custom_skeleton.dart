
import 'package:flutter/material.dart';
import 'package:loader_skeleton/loader_skeleton.dart';
import 'package:market_place/theme/theme_manager.dart';
import 'package:provider/provider.dart'; 

 
 Widget buildCustomSkeleton(BuildContext context) {
    final theme = Provider.of<ThemeManager>(context);
    String modeTheme = theme.themeMode == ThemeMode.dark
        ? 'dark'
        : theme.themeMode == ThemeMode.light
            ? 'light'
            : 'system';
    return modeTheme == 'dark' ? DarkCardSkeleton() : CardSkeleton();
  }
 