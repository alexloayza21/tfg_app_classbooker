import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:tfg_app/config/config.dart';
import 'package:tfg_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:tfg_app/features/auth/presentation/providers/forms/logtin_form_provider.dart';
import 'package:tfg_app/features/auth/presentation/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: const _LoginView(),
    );
  }
}

class _LoginView extends ConsumerWidget {
  const _LoginView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final color = AppTheme().colorSeed;
    final textStyle = Theme.of(context).textTheme;

    final loginFormState = ref.watch(loginFormProvider);

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              
              Lottie.asset(
                'assets/lottieFiles/login_register.json',
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
      
              Container(
                height: 450,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 0.5,
                      offset: const Offset(5, 5)
                    )
                  ]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
      
                      const Text('Iniciar Sesión', style: TextStyle(fontSize: 20),),

                      const SizedBox(height: 20,),
                      const Spacer(),
                      const Spacer(),
                      
                      CustomFormField(
                        isTopField: true,
                        isBottomField: true,
                        label: 'Correo electrónico',
                        hint: 'example@gmail.com',
                        keyboardType: TextInputType.emailAddress,
                        onChanged: ref.read(loginFormProvider.notifier).onEmailChange,
                      ),

                      const Spacer(),
        
                      CustomFormField(
                        isTopField: true,
                        isBottomField: true,
                        label: 'Contraseña',
                        obscureText: true,
                        onChanged: ref.read(loginFormProvider.notifier).onPasswordChange,
                      ),

                      const Spacer(),
        
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        height: 70,
                        width: double.infinity,
                        child: FilledButton.tonal(
                          onPressed: loginFormState.isPosting
                          ? null
                          : () {
                            ref.read(loginFormProvider.notifier).onFormSubmit();
                            FocusManager.instance.primaryFocus?.unfocus();
                            final user = ref.watch(authProvider);
                            print(user.user.toString());
                          }, 
                          child: Text('Iniciar Sesión', style: textStyle.bodyMedium,),
                        ),
                      ),
                      
        
                      TextButton(
                        onPressed: () {
                          context.go('/register');
                        }, 
                        child: Text('¿No estas registrado? Registrate.', style: textStyle.bodySmall,)
                      )
        
                    ],
                  ),
                )
              ),

              const SizedBox(height: 30),
      
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Lottie.asset(
                    'assets/lottieFiles/login_book.json',
                    height: 160,
                    width: 160,
                    fit: BoxFit.cover
                  )
                ],
              )
      
            ],
          ),
        ),
      ),
    );
  }
}