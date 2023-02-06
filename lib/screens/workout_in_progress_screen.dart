import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/blocs/workout_cubit.dart';
import 'package:flutter_bloc_app_complete/states/workout_states.dart';

import '../models/workout.dart';

class WorkoutInProgressScreen extends StatelessWidget {
  const WorkoutInProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _getStats(Workout workout, int workoutElapsed) {
      int workoutTotal = workout.getTotal();

      return {'workoutTitle': workout.title};
    }

    return BlocConsumer<WorkoutCubit, WorkoutState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state.workout!.title!),
            centerTitle: false,
            leading: BackButton(
              onPressed: () => BlocProvider.of<WorkoutCubit>(context).goHome(),
            ),
          ),
          body: Center(
            child: Text('${state.elapsed}'),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
