import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/blocs/workouts_cubit.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';
import 'package:flutter_bloc_app_complete/screens/home_page.dart';

void main() => runApp(const WorkoutTime());

class WorkoutTime extends StatelessWidget {
  const WorkoutTime({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Workouts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Color.fromARGB(255, 66, 74, 96),
          ),
        ),
      ),
      home: BlocProvider<WorkoutsCubit>(
        create: (_) {
          WorkoutsCubit workoutsCubit = WorkoutsCubit();
          if (workoutsCubit.state.isEmpty) {
            print('...loading json since the state is empty');
            workoutsCubit.getWorkouts();
          } else {
            print('... the state is not empty');
          }
          return workoutsCubit;
        },
        child: BlocBuilder<WorkoutsCubit, List<Workout>>(
          builder: (context, state) {
            return HomePage();
          },
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
