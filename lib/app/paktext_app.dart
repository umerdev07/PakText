import 'package:flutter/material.dart';
import 'package:paktext/features/home/HomeProvider.dart';
import 'package:provider/provider.dart';
import '../routes/app_routes.dart';

class PaktextApp extends StatelessWidget {
  const PaktextApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Homeprovider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Paktext',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRoutes.generateRoute,
      )
    );
  }
}
