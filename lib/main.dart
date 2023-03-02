import 'package:flutter/material.dart' hide Router;
import 'package:sr_clone_flutter/router.dart';
import 'package:sr_clone_flutter/service_locator.dart';

Future<void> main() async {
  await ServiceLocator.start();

  runApp(
    MaterialApp.router(
      routerConfig: Router.config,
    ),
  );
}
