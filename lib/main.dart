import 'package:cervical_tracker/features/traction/cubit/traction_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // runApp(const CervicalTractionApp());
  runApp(
    BlocProvider(
      create: (_) => TractionCubit(),
      child: const CervicalTractionApp(),
    ),
  );
}
