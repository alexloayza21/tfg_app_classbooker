import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/auth/presentation/providers/auth_provider.dart';

class AdminProfileScreen extends ConsumerWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final userState = ref.watch(authProvider);
    final user = userState.user;
    return Scaffold(
      appBar: AppBar(
        title: Text(user!.username),
        centerTitle: true,
      ),
      body: Center(child: Text('Admin Perfil'),),
    );
  }
}