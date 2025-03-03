import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../bloc/profile/profile_cubit.dart';
import '../bloc/profile/profile_state.dart';
import '../models/profile_model.dart';
import '../models/bmi_model.dart';

class DetailsScreen extends StatefulWidget {
  final String profileId;

  const DetailsScreen({super.key, required this.profileId});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().selectProfile(widget.profileId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              context.push('/profile?id=${widget.profileId}');
            },
          ),
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.status == ProfileStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.selectedProfile == null) {
            return const Center(child: Text('Profile not found'));
          }

          final profile = state.selectedProfile!;
          final bmiRecords = state.bmiRecords;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileCard(context, profile),
                const SizedBox(height: 24),
                _buildBMIChart(context, bmiRecords),
                const SizedBox(height: 24),
                _buildBMIHistoryList(context, bmiRecords),
                const SizedBox(height: 24),
                _buildFitnessInsights(context, profile),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, ProfileModel profile) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              profile.name,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInfoItem(context, 'Age', '${profile.age} years'),
                ),
                Expanded(
                  child: _buildInfoItem(
                    context,
                    'Gender',
                    _capitalizeFirstLetter(profile.gender),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildInfoItem(
                    context,
                    'Height',
                    '${profile.height} cm',
                  ),
                ),
                Expanded(
                  child: _buildInfoItem(
                    context,
                    'Weight',
                    '${profile.weight} kg',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current BMI',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        profile.calculateBMI().toStringAsFixed(1),
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Category',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getCategoryColor(profile.getBMICategory()),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          profile.getBMICategory(),
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBMIChart(BuildContext context, List<BMIRecord> records) {
    if (records.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('BMI Trend', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 &&
                              value.toInt() < records.length) {
                            // Show only first 3 characters of the month for brevity
                            final month = DateFormat(
                              'MMM',
                            ).format(records[value.toInt()].date);
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                month,
                                style: const TextStyle(fontSize: 10),
                              ),
                            );
                          }
                          return const Text('');
                        },
                        reservedSize: 30,
                      ),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  minX: 0,
                  maxX: (records.length - 1).toDouble(),
                  minY:
                      records
                          .map((e) => e.bmiValue)
                          .reduce((a, b) => a < b ? a : b) -
                      1,
                  maxY:
                      records
                          .map((e) => e.bmiValue)
                          .reduce((a, b) => a > b ? a : b) +
                      1,
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        records.length,
                        (index) =>
                            FlSpot(index.toDouble(), records[index].bmiValue),
                      ),
                      isCurved: true,
                      color: Theme.of(context).primaryColor,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: true),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBMIHistoryList(BuildContext context, List<BMIRecord> records) {
    if (records.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('BMI History', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: records.length,
              itemBuilder: (context, index) {
                final record =
                    records[records.length - 1 - index]; // Show newest first
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: _getCategoryColor(record.category),
                    child: Text(
                      record.bmiValue.toStringAsFixed(1),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    'BMI: ${record.bmiValue.toStringAsFixed(1)} - ${record.category}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    'Weight: ${record.weight}kg | Height: ${record.height}cm\n${DateFormat('MMM d, yyyy').format(record.date)}',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFitnessInsights(BuildContext context, ProfileModel profile) {
    final bmi = profile.calculateBMI();
    final category = profile.getBMICategory();

    String advice = '';
    String exerciseRecommendation = '';
    String dietRecommendation = '';

    switch (category) {
      case 'Underweight':
        advice =
            'Your BMI indicates you are underweight. Focus on gaining healthy weight gradually.';
        exerciseRecommendation =
            'Strength training to build muscle mass. Focus on compound exercises like squats, deadlifts, and bench presses.';
        dietRecommendation =
            'Increase calorie intake with nutrient-dense foods. Include healthy fats, proteins, and complex carbohydrates.';
        break;
      case 'Normal weight':
        advice =
            'Your BMI is in the healthy range. Maintain your current lifestyle with balanced diet and regular exercise.';
        exerciseRecommendation =
            'Mix of cardio and strength training for overall fitness. Aim for 150 minutes of moderate activity per week.';
        dietRecommendation =
            'Continue with a balanced diet including plenty of fruits, vegetables, lean proteins, and whole grains.';
        break;
      case 'Overweight':
        advice =
            'Your BMI indicates you are overweight. Consider making lifestyle changes to achieve a healthier weight.';
        exerciseRecommendation =
            'Cardio exercises like walking, jogging, cycling, or swimming. Start with 30 minutes, 3-5 times per week.';
        dietRecommendation =
            'Focus on portion control and reducing processed foods, sugars, and saturated fats. Increase fiber intake.';
        break;
      case 'Obese':
        advice =
            'Your BMI indicates obesity, which increases health risks. Consult a healthcare provider for a personalized plan.';
        exerciseRecommendation =
            'Low-impact activities like walking, swimming, or water aerobics. Start slowly and gradually increase intensity.';
        dietRecommendation =
            'Work with a nutritionist to create a sustainable caloric deficit. Focus on whole foods and avoiding liquid calories.';
        break;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fitness Insights',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(advice, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 16),
            Text(
              'Exercise Recommendations:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              exerciseRecommendation,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Dietary Suggestions:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              dietRecommendation,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Note: These are general recommendations. For personalized advice, consult with healthcare professionals.',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Underweight':
        return Colors.blue;
      case 'Normal weight':
        return Colors.green;
      case 'Overweight':
        return Colors.orange;
      case 'Obese':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _capitalizeFirstLetter(String text) {
    return text.isEmpty ? text : text[0].toUpperCase() + text.substring(1);
  }
}
