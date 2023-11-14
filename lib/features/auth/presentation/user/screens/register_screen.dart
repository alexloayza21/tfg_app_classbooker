import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:tfg_app/config/theme/app_theme.dart';
import 'package:tfg_app/features/auth/presentation/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: _RegisterView(),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final color = AppTheme().colorSeed;
    final textStyle = Theme.of(context).textTheme;

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

                      const SizedBox(height: 20,),
        
                      CustomFormField(
                        isTopField: true,
                        isBottomField: true,
                        label: 'Nombre de Usuario',
                      ),
        
                      CustomFormField(
                        isTopField: true,
                        isBottomField: true,
                        label: 'Correo electrónico',
                        hint: 'example@gmail.com',
                        keyboardType: TextInputType.emailAddress,
                      ),
        
                      CustomFormField(
                        isTopField: true,
                        isBottomField: true,
                        label: 'Contraseña',
                        obscureText: true,
                      ),

                      const SizedBox(height: 10,),
        
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        height: 60,
                        width: double.infinity,
                        child: FilledButton.tonal(
                          onPressed: () {
                            
                          }, 
                          child: Text('Registrar', style: textStyle.bodyMedium,),
                        ),
                      ),
                      
        
                      TextButton(
                        onPressed: () {
                          context.go('/login');
                        }, 
                        child: Text('Ya estas registrado? Inicia sesión.', style: textStyle.bodySmall,)
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