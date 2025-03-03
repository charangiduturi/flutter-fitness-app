// import 'package:equatable/equatable.dart';

// enum ThemeMode { light, dark }

// class ThemeState extends Equatable {
//   final ThemeMode themeMode;

//   const ThemeState({this.themeMode = ThemeMode.light});

//   ThemeState copyWith({ThemeMode? themeMode}) {
//     return ThemeState(themeMode: themeMode ?? this.themeMode);
//   }

//   @override
//   List<Object?> get props => [themeMode];
// }

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState({this.themeMode = ThemeMode.light});

  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(themeMode: themeMode ?? this.themeMode);
  }

  @override
  List<Object?> get props => [themeMode];
}
