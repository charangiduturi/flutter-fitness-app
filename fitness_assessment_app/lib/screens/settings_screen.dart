// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/theme/theme_cubit.dart';
// import '../bloc/theme/theme_state.dart';

// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Settings')),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           Card(
//             child: BlocBuilder<ThemeCubit, ThemeState>(
//               builder: (context, state) {
//                 return SwitchListTile(
//                   title: const Text('Dark Mode'),
//                   subtitle: const Text('Toggle between light and dark theme'),
//                   value: state.themeMode == ThemeMode.dark,
//                   onChanged: (value) {
//                     context.read<ThemeCubit>().toggleTheme();
//                   },
//                   secondary: Icon(
//                     state.themeMode == ThemeMode.dark
//                         ? Icons.dark_mode
//                         : Icons.light_mode,
//                   ),
//                 );
//               },
//             ),
//           ),
//           const SizedBox(height: 16),
//           Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'About BMI',
//                     style: Theme.of(context).textTheme.titleLarge,
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Body Mass Index (BMI) is a value derived from the weight and height of a person. It is defined as the body weight divided by the square of the body height, and is expressed in units of kg/m².',
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     'BMI Categories:',
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   const SizedBox(height: 8),
//                   _buildBMICategory(
//                     context,
//                     'Underweight',
//                     'Less than 18.5',
//                     Colors.blue,
//                   ),
//                   _buildBMICategory(
//                     context,
//                     'Normal weight',
//                     '18.5 - 24.9',
//                     Colors.green,
//                   ),
//                   _buildBMICategory(
//                     context,
//                     'Overweight',
//                     '25 - 29.9',
//                     Colors.orange,
//                   ),
//                   _buildBMICategory(
//                     context,
//                     'Obese',
//                     '30 or higher',
//                     Colors.red,
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Note: BMI is a screening tool but isn\'t diagnostic of body fatness or health. Factors like muscle mass, bone density, and ethnic differences aren\'t accounted for in BMI calculations.',
//                     style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                       fontStyle: FontStyle.italic,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'App Information',
//                     style: Theme.of(context).textTheme.titleLarge,
//                   ),
//                   const SizedBox(height: 16),
//                   _buildInfoRow(context, 'Version', '1.0.0'),
//                   _buildInfoRow(context, 'Built with', 'Flutter'),
//                   _buildInfoRow(context, 'State Management', 'BLoC/Cubit'),
//                   _buildInfoRow(context, 'Navigation', 'GoRouter'),
//                   _buildInfoRow(context, 'Storage', 'Hive'),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBMICategory(
//     BuildContext context,
//     String category,
//     String range,
//     Color color,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Row(
//         children: [
//           Container(
//             width: 12,
//             height: 12,
//             decoration: BoxDecoration(
//               color: color,
//               borderRadius: BorderRadius.circular(6),
//             ),
//           ),
//           const SizedBox(width: 8),
//           Text(
//             category,
//             style: Theme.of(
//               context,
//             ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(width: 8),
//           Text('(BMI $range)', style: Theme.of(context).textTheme.bodyMedium),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoRow(BuildContext context, String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Row(
//         children: [
//           Text(
//             '$label: ',
//             style: Theme.of(
//               context,
//             ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
//           ),
//           Text(value, style: Theme.of(context).textTheme.bodyMedium),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/theme/theme_cubit.dart';
import '../bloc/theme/theme_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return SwitchListTile(
                  title: const Text('Dark Mode'),
                  subtitle: const Text('Toggle between light and dark theme'),
                  value:
                      state.themeMode ==
                      ThemeMode.dark, // ✅ Ensure ThemeMode is correctly used
                  onChanged: (value) {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                  secondary: Icon(
                    state.themeMode == ThemeMode.dark
                        ? Icons.dark_mode
                        : Icons.light_mode,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About BMI',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Body Mass Index (BMI) is a value derived from the weight and height of a person. It is defined as the body weight divided by the square of the body height, and is expressed in units of kg/m².',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'BMI Categories:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  _buildBMICategory(
                    context,
                    'Underweight',
                    'Less than 18.5',
                    Colors.blue,
                  ),
                  _buildBMICategory(
                    context,
                    'Normal weight',
                    '18.5 - 24.9',
                    Colors.green,
                  ),
                  _buildBMICategory(
                    context,
                    'Overweight',
                    '25 - 29.9',
                    Colors.orange,
                  ),
                  _buildBMICategory(
                    context,
                    'Obese',
                    '30 or higher',
                    Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Note: BMI is a screening tool but isn\'t diagnostic of body fatness or health. Factors like muscle mass, bone density, and ethnic differences aren\'t accounted for in BMI calculations.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'App Information',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(context, 'Version', '1.0.0'),
                  _buildInfoRow(context, 'Built with', 'Flutter'),
                  _buildInfoRow(context, 'State Management', 'BLoC/Cubit'),
                  _buildInfoRow(context, 'Navigation', 'GoRouter'),
                  _buildInfoRow(context, 'Storage', 'Hive'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBMICategory(
    BuildContext context,
    String category,
    String range,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            category,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Text('(BMI $range)', style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(value, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
