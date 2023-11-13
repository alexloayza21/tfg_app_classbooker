import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tfg_app/config/config.dart';
import 'package:tfg_app/features/auth/presentation/providers/aula_provider.dart';
import 'package:tfg_app/features/auth/presentation/widgets/widgets.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';

class AulaScreen extends ConsumerWidget {
  const AulaScreen({super.key, required this.idAula});

  final String idAula;

  @override
  Widget build(BuildContext context, WidgetRef ref){

    final aulaState = ref.watch(aulaProvider(idAula));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Aula'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(child: _AulaScreenView(aula: aulaState.aula!)),
    );
  }
}

class _AulaScreenView extends ConsumerStatefulWidget {
  const _AulaScreenView({
    required this.aula
  });

  final Aula aula;

  @override
  _NewEscuelaViewState createState() => _NewEscuelaViewState();
}

class _NewEscuelaViewState extends ConsumerState<_AulaScreenView> {

  final _textController = TextEditingController();
  late String horaEntrada = '';
  late String horaSalida = '';
  late String? valor = '';
  late bool cadaHora = false;
  late bool cadaMediaHora = false;

  List<String> opciones = ['media hora', 'hora'];

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 600, 
                width: double.infinity, 
                decoration: BoxDecoration(
                  color: AppTheme().colorSeed.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 8,
                      color: Colors.black54,
                      spreadRadius: 1,
                      offset: Offset(5, 5)
                    )
                  ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40,),
                child: Column(
                  children: [
              
                    CustomFormField(
                      isTopField: true,
                      isBottomField: true,
                      label: 'Nombre del aula',
                      initialValue: widget.aula.nombreAula,
                    ),
              
                    Text('\nHorario', style: textStyle.titleLarge,),
              
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Hora de entrada', style: textStyle.titleMedium),                
                          SizedBox(
                            width: 200,
                            child: TextField(
                              controller: _textController,
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText: horaEntrada,
                                hintStyle: const TextStyle(fontSize: 20),
                                filled: true
                              ),
                              onTap: _selectEntrada,
                              onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                            ),
                          ),
                        ],
                      ),
                    ),
              
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Hora de salida', style: textStyle.titleMedium),                
                          SizedBox(
                            width: 200,
                            child: TextField(
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText: horaSalida,
                                hintStyle: const TextStyle(fontSize: 20),
                                filled: true
                              ),
                              onTap: _selectSalida,
                              onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                            ),
                          ),
                        ],
                      ),
                    ),
              
                    
                    Text('\nHorario de reserva cada:\n', style: textStyle.titleLarge),
              
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
              
                        Row(
                          children: [
                            Checkbox(
                              value: cadaHora,
                              onChanged: (value) {
                                setState(() {
                                  cadaHora = !cadaHora;
                                });
                              },
                            ),
              
                            Text('Hora', style: textStyle.titleMedium)
                          ],
                        ),
              
                        Row(
                          children: [
                            Checkbox(
                              value: cadaMediaHora,
                              onChanged: (value) {
                                setState(() {
                                  cadaMediaHora = !cadaMediaHora;
                                });
                              },
                            ),
                  
                            Text('Media Hora', style: textStyle.titleMedium)
                          ],
                        )
              
                      ],
                    ),
              
                    
                    Text('\nNumero de asientos:\n', style: textStyle.titleLarge),
              
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        IconButton(
                          onPressed: () {
                            
                          }, 
                          icon: Icon(Icons.remove_circle_outline, color: Colors.white, size: 30,)
                        ),

                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)
                          ),
                          child: const Center(child: Text('1'))
                        ),

                        IconButton(
                          onPressed: () {
                            
                          }, 
                          icon: Icon(Icons.add_circle, color: Colors.white, size: 30,)
                        )
              
                      ],
                    ),
              
                  ],
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
          
                TextButton(
                  onPressed: () {
                  
                }, 
                child: Text('Cancelar', style: GoogleFonts.montserratAlternates()
                .copyWith( color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold ),)
                ),
          
                TextButton(
                  onPressed: () {
                  
                }, 
                child: Text('Guardar', style: GoogleFonts.montserratAlternates()
                .copyWith( color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold ),)
                )
          
              ],
            ),
          )

        ],
      ),
    );
  }

  Future<void> _selectSalida() async {
    TimeOfDay? hora = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now()
    );

    if (hora!=null) {
      setState(() {
        horaSalida = '${hora.hour}:${hora.minute.toString().padLeft(2,'0')}';
      });
    }
  }
  
  Future<void> _selectEntrada() async {
    TimeOfDay? hora = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now()
    );

    if (hora!=null) {
      setState(() {
        horaEntrada = '${hora.hour}:${hora.minute.toString().padLeft(2,'0')}';
      });
    }
  }
}