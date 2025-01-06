
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_owner/utils/auth/bloc/auth_bloc_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthUser(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Center(
            child: Text(
              "ArchiTechIraq",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        );
  }
}
