import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'common/widgets/error/error_screen.dart';
import 'common/widgets/loading/loading.dart';
import 'core/configs/theme/app_theme.dart';
import 'features/auth/controller/auth_controller.dart';
import 'firebase_options.dart';
import 'features/auth/screens/siginin.dart';
import 'features/home/pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: 'https://bxzevvlnraudejtlutmt.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ4emV2dmxucmF1ZGVqdGx1dG10Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDYwNTM3NzYsImV4cCI6MjA2MTYyOTc3Nn0.Y5RLlMBjsI-9OL_XXRwqPbD8bR8dCqasX69BKU9bysY',
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: AppTheme.appTheme,
      debugShowCheckedModeBanner: false,
      home: ref
          .watch(userDataAuthProvider)
          .when(
            data: (user) {
              if (user == null) {
                return SigninPage();
              } else {
                return HomePage(userId: user.userId);
              }
            },
            error: (error, stackTrace) => ErrorScreen(error: error.toString()),
            loading: () => const Loader(),
          ),
    );
  }
}
