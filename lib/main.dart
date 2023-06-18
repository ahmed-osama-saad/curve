import 'package:curve/blocs/score/score_bloc.dart';
import 'package:curve/blocs/settings/settings_bloc.dart';
import 'package:curve/flame_layer.dart';
import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

// CurveGame _curveGame = CurveGame();
Future<void> main() async {
  // Ensures that all bindings are initialized
  // before was start calling hive and flame code
  // dealing with platform channels.
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  // Makes the game full screen and portrait only.
  Flame.device.fullScreen();
  Flame.device.setPortrait();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Curve Game',
      home: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsBloc>(
            create: (_) => SettingsBloc(),
          ),
          BlocProvider<ScoreBloc>(
            create: (_) => ScoreBloc(),
          )
        ],
        child: const Scaffold(body: FlameLayer()),
      ),
    );
  }
}
