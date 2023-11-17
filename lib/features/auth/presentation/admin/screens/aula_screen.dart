import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tfg_app/config/config.dart';
import 'package:tfg_app/features/auth/presentation/providers/aula_provider.dart';
import 'package:tfg_app/features/auth/presentation/providers/forms/aula_form_provider.dart';
import 'package:tfg_app/features/auth/presentation/widgets/widgets.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';

class AulaScreen extends ConsumerWidget {
  const AulaScreen({super.key, required this.idAula});

  final String idAula;

  @override
  Widget build(BuildContext context, WidgetRef ref){

    final aulaState = ref.watch(aulaProvider(idAula));
    final aula = aulaState.aula;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Aula'),
        centerTitle: true,
      ),
      body: (aula == null) ? const Center(child: CircularProgressIndicator()) : SingleChildScrollView(child: _AulaScreenView(aula: aula, counter: aula.asientos.length,)),
    );
  }
}

class _AulaScreenView extends ConsumerStatefulWidget {
  const _AulaScreenView({
    required this.aula,
    required this.counter
  });

  final Aula aula;
  final int counter;

  @override
  _NewEscuelaViewState createState() => _NewEscuelaViewState();
}

class _NewEscuelaViewState extends ConsumerState<_AulaScreenView> {

  late int counter = widget.counter;

  List<String> opciones = ['media hora', 'hora'];

  void incrementCounter(){
    setState(() {
      counter++;
    });
  }

  void decrementCounter(){
    if (counter > 0) {
      setState(() {
        counter--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final aulaForm = ref.watch(aulaFormProvider(widget.aula));
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
                  color: Colors.white, 
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: AppTheme().colorSeed.withOpacity(0.5),
                      spreadRadius: 0.5,
                      offset: const Offset(5, 5)
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
                      hint: 'ejem. {Aula 001}',
                      initialValue: aulaForm.nombreAula,
                      onChanged: ref.watch(aulaFormProvider(widget.aula).notifier).onNombreAulaChanged,
                    ),

                    const SizedBox(height: 10,),
                    Text('Horario', style: textStyle.bodyLarge,),
              
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Hora de entrada', style: textStyle.bodyMedium),                
                          SizedBox(
                            width: 200,
                            child: TextField(
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText: aulaForm.horaEntrada,
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
                          Text('Hora de salida', style: textStyle.bodyMedium),                
                          SizedBox(
                            width: 200,
                            child: TextField(
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText: aulaForm.horaSalida,
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
              
                    
                    Text('\nHorario de reserva cada:', style: textStyle.bodyLarge),
              
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
              
                        Row(
                          children: [
                            Checkbox(
                              value: !aulaForm.mediaHora,
                              onChanged: (value) => ref.watch(aulaFormProvider(widget.aula).notifier).onMediaHoraChanged(value),
                            ),
              
                            Text('Hora', style: textStyle.bodyMedium)
                          ],
                        ),
              
                        Row(
                          children: [
                            Checkbox(
                              value: aulaForm.mediaHora,
                              onChanged: (value) => ref.watch(aulaFormProvider(widget.aula).notifier).onMediaHoraChanged(!value!),
                            ),
                  
                            Text('Media Hora', style: textStyle.bodyMedium)
                          ],
                        )
              
                      ],
                    ),
              
                    
                    Text('\nNumero de asientos:\n', style: textStyle.bodyLarge),
              
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        IconButton(
                          onPressed: () {
                            decrementCounter();
                          }, 
                          icon: const Icon(Icons.remove_circle_outline, color: Colors.black, size: 30,)
                        ),

                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(50)
                          ),
                          child: Center(
                            child: Text('$counter', style: const TextStyle(color: Colors.white),)
                          )
                        ),

                        IconButton(
                          onPressed: () {
                            incrementCounter();
                          }, 
                          icon: const Icon(Icons.add_circle, color: Colors.black, size: 30,)
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
                  context.pop('/adminProfile');
                }, 
                child: Text('Cancelar', style: GoogleFonts.montserratAlternates()
                .copyWith( color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold ),)
                ),
          
                TextButton(
                  onPressed: (widget.aula.idAula == 'new' && counter==0) 
                  ? () {
                    showDialog(
                      context: context, 
                      builder: (context) {
                        return AlertDialog(
                          title: Text('El aula debe tener al menos 1 aula', style: textStyle.bodyLarge, textAlign: TextAlign.center,),
                        );
                      },
                    );
                  } 
                  : () async{
                    ref.read(aulaFormProvider(widget.aula).notifier).onAsientosChanged(await createAsientos(counter));
                    ref.read(aulaFormProvider(widget.aula).notifier).onFormSubmit();
                    // ignore: use_build_context_synchronously
                    context.pop('/adminProfile');  
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

  Future<List<Asiento>> createAsientos(int counter) async{
    late List<Asiento> asientos = [];
    for (var i = 1; i <= counter; i++) {
      final asiento = Asiento(numeroAsiento: i);
      asientos.add(asiento);
    }
    return asientos;
  }

  Future<void> _selectSalida() async {
    final aulaForm = ref.watch(aulaFormProvider(widget.aula).notifier);
    TimeOfDay? hora = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now()
    );

    if (hora!=null) {
      aulaForm.onHoraSalidaChanged('${hora.hour}:${hora.minute.toString().padLeft(2,'0')}');
    }
  }
  
  Future<void> _selectEntrada() async {
    final aulaForm = ref.watch(aulaFormProvider(widget.aula).notifier);

    TimeOfDay? hora = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now()
    );

    if (hora!=null) {
      aulaForm.onHoraEntradaChanged('${hora.hour}:${hora.minute.toString().padLeft(2,'0')}');
    }
  }
}