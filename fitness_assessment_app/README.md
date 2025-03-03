
# **Flutter Fitness Assessment App**  

A **fitness assessment application** built with **Flutter**, featuring **BMI calculation, user profile management, and theme customization**. The app follows **BLoC for state management, GoRouter for navigation, and Hive for local storage**.

## **Table of Contents**
- [Features](#features)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [State Management (BLoC)](#state-management-bloc)
- [Navigation (GoRouter)](#navigation-gorouter)
- [Storage (Hive)](#storage-hive)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)


---

## **Features**  
✔ **BMI Calculation** – Calculates BMI based on user input.  
✔ **User Profile Management** – Stores and manages user fitness data.  
✔ **Theming Support** – Light/Dark mode toggling.  
✔ **Persistent Storage** – Stores user data using Hive.  
✔ **GoRouter Navigation** – Structured and scalable navigation.  

---

## **Architecture**  
The app follows **Clean Architecture**, dividing concerns into:  

- **Presentation Layer** → UI & State Management (BLoC).  
- **Domain Layer** → Business Logic (Use Cases & Models).  
- **Data Layer** → Persistent Storage (Hive).  
- **Routing Layer** → Screen navigation (GoRouter).  

---

## **Project Structure**  
📂 **flutter-fitness-app**  
```
lib/
│── bloc/  
│   ├── profile/  
│   │   ├── profile_cubit.dart  
│   │   ├── profile_state.dart  
│   ├── theme/  
│   │   ├── theme_cubit.dart  
│   │   ├── theme_state.dart  
│── models/  
│   ├── bmi_model.dart  
│   ├── bmi_model.g.dart  
│   ├── profile_model.dart  
│   ├── profile_model.g.dart  
│── repositories/  
│   ├── profile_repository.dart  
│── screens/  
│   ├── details_screen.dart  
│   ├── home_screen.dart  
│   ├── profile_screen.dart  
│   ├── settings_screen.dart  
│   ├── splash_screen.dart  
│── utils/  
│   ├── router.dart  
│   ├── theme.dart  
│── main.dart  
```  

---

## **State Management (BLoC)**
The app uses **Cubit (BLoC)** to manage user profile and theme states.

📌 **Example: Profile Cubit (`profile_cubit.dart`)**  
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_state.dart';
import '../../models/profile_model.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  void updateProfile(ProfileModel profile) {
    emit(ProfileLoaded(profile));
  }
}
```

📌 **Example: Theme Cubit (`theme_cubit.dart`)**  
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeLight());

  void toggleTheme() {
    emit(state is ThemeLight ? ThemeDark() : ThemeLight());
  }
}
```

---

## **Navigation (GoRouter)**
The app uses **GoRouter** for navigation.

📌 **Example: Router Configuration (`router.dart`)**  
```dart
import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/settings_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/profile', builder: (context, state) => ProfileScreen()),
    GoRoute(path: '/settings', builder: (context, state) => SettingsScreen()),
  ],
);
```

---

## **Storage (Hive)**
The app uses **Hive** for local storage.

📌 **Example: Profile Model (`profile_model.dart`)**  
```dart
import 'package:hive/hive.dart';

part 'profile_model.g.dart';

@HiveType(typeId: 1)
class ProfileModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int age;

  @HiveField(2)
  final double weight;

  @HiveField(3)
  final double height;

  ProfileModel({required this.name, required this.age, required this.weight, required this.height});
}
```

---

## **Getting Started**

### **Prerequisites**
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/)
- [Hive Storage](https://pub.dev/packages/hive)

### **Installation**
1️⃣ **Clone the repository**  
```bash
git clone https://github.com/charangiduturi/flutter-fitness-app.git
cd flutter-fitness-app
```
2️⃣ **Install dependencies**  
```bash
flutter pub get
```
3️⃣ **Run the app**  
```bash
flutter run
```

---

## **Usage**
1️⃣ **Launch the app**  
2️⃣ **Navigate to profile settings** to enter user details.  
3️⃣ **Calculate BMI** and track progress.  
4️⃣ **Toggle Dark/Light mode** from settings.  

---



🔥 **Enjoy building your fitness goals with this app!** Let me know if you need further improvements. 🚀
