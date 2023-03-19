import 'package:flutter/material.dart' hide Router;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sr_clone_flutter/bootstrap.dart';
import 'package:sr_clone_flutter/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final bootstrap = Bootstrap();
  final bootstrapData = await bootstrap();

  runApp(
    ProviderScope(
      child: MaterialApp.router(
        routerConfig: Router.config(RouterData(bootstrapData.playerContent)),
      ),
    ),
  );
}
