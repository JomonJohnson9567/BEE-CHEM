import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_machine_task/presentation/screens/personal%20details/widget/new_header.dart';
import 'package:http/http.dart' as http;

import 'core/constants/app_colors.dart';
import 'data/repository/auth_repository.dart';
import 'data/repository/personnel_repository.dart';
import 'data/services/api_service.dart';
import 'presentation/screens/splash/app_bootstrapper.dart';

void main() {
  runApp(const BeeChemApp());
}

class BeeChemApp extends StatelessWidget {
  const BeeChemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(client: http.Client()),
        ),
        RepositoryProvider<ApiService>(
          create: (_) => ApiService(client: http.Client()),
        ),
        RepositoryProvider<PersonnelRepository>(
          create: (context) => PersonnelRepository(
            apiService: RepositoryProvider.of<ApiService>(context),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Bee Chem',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: AppColors.scaffoldBackground,
          fontFamily: 'Poppins',
        ),
        home: const AppBootstrapper(),
      ),
    );
  }
}
