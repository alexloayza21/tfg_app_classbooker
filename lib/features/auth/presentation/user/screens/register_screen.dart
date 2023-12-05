import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:tfg_app/config/theme/app_theme.dart';
import 'package:tfg_app/features/auth/presentation/providers/forms/register_form_provider.dart';
import 'package:tfg_app/features/auth/presentation/providers/providers.dart';
import 'package:tfg_app/features/auth/presentation/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: const _RegisterView(),
    );
  }
}

class _RegisterView extends ConsumerWidget {
  const _RegisterView({
    super.key,
  });

  void showSnackBar(BuildContext context, String message){
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final color = AppTheme().colorSeed;
    final textStyle = Theme.of(context).textTheme;

    final registerFormState = ref.watch(registerFormProvider);

    ref.listen(authProvider, (previous, next){
      if (next.errorMessage.isEmpty) return;
      showSnackBar(context, next.errorMessage);
    });

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
                height: 480,
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
      
                      const Text('Registrar', style: TextStyle(fontSize: 20),),

                      const SizedBox(height: 30,),
        
                      CustomFormField(
                        isTopField: true,
                        isBottomField: true,
                        label: 'Nombre de Usuario',
                        onChanged: ref.read(registerFormProvider.notifier).onUsernameChange,                        
                      ),

                      const Spacer(),
        
                      CustomFormField(
                        isTopField: true,
                        isBottomField: true,
                        label: 'Correo electrónico',
                        hint: 'example@gmail.com',
                        keyboardType: TextInputType.emailAddress,
                        onChanged: ref.read(registerFormProvider.notifier).onEmailChange,
                      ),

                      const Spacer(),
        
                      CustomFormField(
                        isTopField: true,
                        isBottomField: true,
                        label: 'Contraseña',
                        obscureText: true,
                        onChanged: ref.read(registerFormProvider.notifier).onPasswordChange,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                      
                            Checkbox(
                              value: !registerFormState.isAdmin, 
                              onChanged: (value) => ref.read(registerFormProvider.notifier).onIsAdminChanged(value),
                            ),
                            
                            const Text('Alumno'),
                      
                            const Spacer(),
                      
                            Checkbox(
                              value: registerFormState.isAdmin, 
                              onChanged: (value) => ref.read(registerFormProvider.notifier).onIsAdminChanged(!value!),
                            ),
                            
                            const Text('Administrador'),
                      
                          ],
                        ),
                      ),

                      const SizedBox(height: 10,),
        
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        height: 60,
                        width: double.infinity,
                        child: FilledButton.tonal(
                          onPressed: registerFormState.isPosting ? null
                          : () {
                            ref.read(registerFormProvider.notifier).onFormSubmit();
                          }, 
                          child: Text('Registrar', style: textStyle.bodyMedium,),
                        ),
                      ),
                      
        
                      TextButton(
                        onPressed: () {
                          context.go('/login');
                        }, 
                        child: Text('¿Ya estas registrado? Inicia sesión.', style: textStyle.bodySmall,)
                      )
        
                    ],
                  ),
                )
              ),
              
              const SizedBox(height: 30,),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Lottie.asset(
                    'assets/lottieFiles/dude_standing.json',
                    height: 130,
                    width: 130,
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