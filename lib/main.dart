import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/blocs/workout_cubit.dart';
import 'package:flutter_bloc_app_complete/blocs/workouts_cubit.dart';
import 'package:flutter_bloc_app_complete/screens/edit_workout_screen.dart';
import 'package:flutter_bloc_app_complete/screens/home_screen.dart';
import 'package:flutter_bloc_app_complete/screens/workout_in_progress_screen.dart';
import 'package:flutter_bloc_app_complete/states/workout_states.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  HydratedBlocOverrides.runZoned(
    () => runApp(const WorkoutTime()),
    storage: storage,
  );
}

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
      home: MultiBlocProvider(
        providers: [
          BlocProvider<WorkoutsCubit>(
            create: (_) {
              WorkoutsCubit workoutsCubit = WorkoutsCubit();
              if (workoutsCubit.state.isEmpty) {
                workoutsCubit.getWorkouts();
              }
              return workoutsCubit;
            },
          ),
          BlocProvider<WorkoutCubit>(
            create: (_) {
              return WorkoutCubit();
            },
          ),
        ],
        child:
            BlocBuilder<WorkoutCubit, WorkoutState>(builder: (context, state) {
          if (state is WorkoutInitial) {
            return const HomeScreen();
          } else if (state is WorkoutEditing) {
            return const EditWorkoutScreen();
          }
          return const WorkoutInProgressScreen();
        }),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
