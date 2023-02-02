import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/blocs/workouts_cubit.dart';

import '../models/workout.dart';

class EditExerciseScreen extends StatefulWidget {
  const EditExerciseScreen({
    super.key,
    this.workout,
    required this.index,
    this.exIndex,
  });
  final Workout? workout;
  final int index;
  final int? exIndex;

  @override
  State<EditExerciseScreen> createState() => _EditExerciseScreenState();
}

class _EditExerciseScreenState extends State<EditExerciseScreen> {
  TextEditingController? _title;

  @override
  void initState() {
    _title = TextEditingController(
        text: widget.workout!.exercises[widget.exIndex!].title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                textAlign: TextAlign.center,
                controller: _title,
                onChanged: (value) => setState(() {
                  widget.workout!.exercises[widget.exIndex!] = widget
                      .workout!.exercises[widget.exIndex!]
                      .copyWith(title: value);
                  BlocProvider.of<WorkoutsCubit>(context).saveWorkout(
                    widget.workout!,
                    widget.index,
                  );
                }),
              ),
            )
          ],
        )
      ],
    );
  }
}
