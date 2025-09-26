import 'package:flutter/cupertino.dart';

import 'core/di/dependency_container.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}
