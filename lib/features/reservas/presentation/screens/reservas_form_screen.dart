import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';
import 'package:tfg_app/features/reservas/presentation/providers/reservas_form_provider.dart';
import 'package:tfg_app/features/reservas/presentation/providers/reservas_provider.dart';

class ReservasScreen extends ConsumerWidget {
  const ReservasScreen({super.key, required this.idAula});

  final String idAula;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final reservaFormState = ref.watch(reservaFormProvider(idAula));

    return reservaFormState.isLoading 
      ? const Scaffold(body: Center(child: CircularProgressIndicator(),)) 
      : Scaffold(
        appBar: AppBar(
          title: Text('Reservas: Aula ${reservaFormState.aula!.nombreAula}'),
          centerTitle: true,
        ),
        body:  _ReservasView(aula: reservaFormState.aula!),
      );
  }
}

class _ReservasView extends ConsumerStatefulWidget {
  const _ReservasView({
    required this.aula,
  });

  final Aula aula;

  @override
  _ReservasViewState createState() => _ReservasViewState();
}

class _ReservasViewState extends ConsumerState<_ReservasView> {

  final TextEditingController _dateController = TextEditingController();


  final horasEntrada = ['16:00','17:00', '18:00', '19:00', '20:00'];
  final horasSalida = ['17:00','18:00', '19:00', '20:00','21:00'];

  String? horaEntrada = '';
  String? horaSalida = '';

  late List<bool> isSelected;
  late List<Asiento> listaAsientoToReserva = [];

  @override
  void initState() {
    super.initState();
    isSelected = List.generate(widget.aula.asientos!.length, (index) => false);
    _dateController.text = DateTime.now().toString().split(' ')[0];
  }


  @override
  Widget build(BuildContext context) {
    final reservaFormState = ref.watch(reservaFormProvider(widget.aula.idAula).notifier);
    final reservasState = ref.watch(reservaProvider(_dateController.text));
    
    final textStyle = Theme.of(context).textTheme;
    final List<Asiento> asientosDeAula = widget.aula.asientos!;

    late List<Asiento> asientosResevas = [];

    for (final reserva in reservasState.reservas) {
      for (final asiento in reserva.asientos) {
        if (asiento.idAula == widget.aula.idAula) {
          asientosResevas.add(asiento);
        }
      }
    }

    print(asientosResevas.length);
    
    return Column(
      children: [
    
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,  vertical: 10),
          child: Column(
            children: [
              Center(child: Text('Fecha de Reserva', style: textStyle.bodyMedium)),
              TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  hintText: _dateController.text,
                  filled: true,
                  prefixIcon: const Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: _selectDate,
                onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
              ),
            ],
          ),
        ),
    
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,  vertical: 5),
          child: Column(
            children: [
              Center(child: Text('Hora de entrada', style: textStyle.bodyMedium)),
              
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xff0017FF).withOpacity(0.07)
                ),
                child: DropdownButtonFormField(
                  items: horasEntrada.map((hora) {
                    return DropdownMenuItem(
                      value: hora,
                      child: Center(child: Text(hora, style: textStyle.bodyMedium,)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      horaEntrada = value;
                      listaAsientoToReserva = [];
                      // isSelected = List.generate(asientosDeAula.length, (index) => false); //TODO:
                    });
                  },
                  icon: const Icon(Icons.access_time_outlined),
    
                ),
              )
    
            ],
          ),
        ),
    
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 30),
          child: Column(
            children: [
              Center(child: Text('Hora de salida', style: textStyle.bodyMedium)),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xff0017FF).withOpacity(0.07)
                ),
                child: DropdownButtonFormField(
                  items: horasSalida.map((hora) {
                    return DropdownMenuItem(
                      value: hora,
                      child: Center(child: Text(hora, style: textStyle.bodyMedium,)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      horaSalida = value;
                      listaAsientoToReserva = [];
                      // isSelected = List.generate(asientosDeAula.length, (index) => false);//TODO:
                    });
                  },
                  icon: const Icon(Icons.access_time_outlined),
                  
                ),
              )
            ],
          ),
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisExtent: 50,
                mainAxisSpacing: 2,
              ),
              shrinkWrap: true,
              itemCount: asientosDeAula.length, 
              itemBuilder: (context, index) {
                  
                for (var j = 0; j < asientosResevas.length; j++) {
            
                  if(
                    asientosDeAula[index].numeroAsiento == asientosResevas[j].numeroAsiento 
                    && (horaEntrada == asientosResevas[j].horaEntrada && horaSalida == asientosResevas[j].horaSalida)) {
                    return const _ButtonAsiento(
                      colorButton: Colors.red, 
                      onPressed: null,
                      isSelected: false,
                    );
                  }
            
                  if ((asientosDeAula[index].numeroAsiento == asientosResevas[j].numeroAsiento &&
                      stringNum(horaEntrada!) < stringNum(asientosResevas[j].horaEntrada!) && 
                      horaSalida == asientosResevas[j].horaSalida
                      )
                    || (asientosDeAula[index].numeroAsiento == asientosResevas[j].numeroAsiento &&
                      horaEntrada == asientosResevas[j].horaEntrada && 
                      stringNum(horaSalida!) >  stringNum(asientosResevas[j].horaSalida!)
                      )
                    || (asientosDeAula[index].numeroAsiento == asientosResevas[j].numeroAsiento &&
                      stringNum(horaEntrada!) > stringNum(asientosResevas[j].horaEntrada!) && 
                      horaSalida == asientosResevas[j].horaSalida
                      )
                    || (asientosDeAula[index].numeroAsiento == asientosResevas[j].numeroAsiento &&
                      horaEntrada == asientosResevas[j].horaEntrada && 
                      stringNum(horaSalida!) <  stringNum(asientosResevas[j].horaSalida!)
                      )
                    || (asientosDeAula[index].numeroAsiento == asientosResevas[j].numeroAsiento &&
                      stringNum(horaEntrada!) < stringNum(asientosResevas[j].horaEntrada!) && 
                      stringNum(horaSalida!) >  stringNum(asientosResevas[j].horaSalida!)
                      )
                    || (asientosDeAula[index].numeroAsiento == asientosResevas[j].numeroAsiento &&
                      stringNum(horaEntrada!) > stringNum(asientosResevas[j].horaEntrada!) && 
                      stringNum(horaSalida!) <  stringNum(asientosResevas[j].horaSalida!)
                      )
                    || (asientosDeAula[index].numeroAsiento == asientosResevas[j].numeroAsiento &&
                      stringNum(horaSalida!) >  stringNum(asientosResevas[j].horaSalida!) &&
                      stringNum(horaEntrada!) > stringNum(asientosResevas[j].horaEntrada!) && 
                      stringNum(horaEntrada!) < stringNum(asientosResevas[j].horaSalida!)
                      )
                    || (asientosDeAula[index].numeroAsiento == asientosResevas[j].numeroAsiento &&
                      stringNum(horaEntrada!) < stringNum(asientosResevas[j].horaEntrada!) && 
                      stringNum(horaSalida!) <  stringNum(asientosResevas[j].horaSalida!) &&
                      stringNum(horaSalida!) >  stringNum(asientosResevas[j].horaEntrada!)
                      )
                    ) {
                    return _ButtonAsiento(
                      colorButton: Colors.deepPurple,
                      isSelected: false, 
                      onPressed: () {
                        showDialog(
                          context: context, 
                          builder: (context) {
                            return AlertDialog.adaptive(
                              title: Center(child: Text('Asiento Dudoso', style: textStyle.bodyLarge,)),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'El asiento ${asientosDeAula[index].numeroAsiento} '
                                    'está reservado de ${asientosResevas[j].horaEntrada} ' 
                                    'a ${asientosResevas[j].horaSalida} '
                                    'por lo que no puedes reservar este asiento a la hora selecionada, '
                                    'por favor cambie la hora de entrada o la hora de salida.'
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    );
                  }
                }
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: IconButton.filledTonal(
                    onPressed: (){
                      setState(() { isSelected[index] = !isSelected[index]; });
                      // print(asientos[index].toString());
                      if (isSelected[index]) {
                        listaAsientoToReserva.add(asientosDeAula[index]);
                      }else{
                        listaAsientoToReserva.removeWhere((element) => element.numeroAsiento == asientosDeAula[index].numeroAsiento);
                      }
                      // print(listaAsientoToReserva.length); 
                    }, 
                    icon: const Icon(Icons.chair_outlined), 
                    selectedIcon: const Icon(Icons.chair),
                    isSelected: isSelected[index],
                    color: Colors.green,
                    disabledColor: Colors.red,
                  ),
                );
              },
            ),
          ),
        ),
    
        Container(
          width: double.infinity,
          height: 70,
          margin: const EdgeInsets.only(right: 20, left: 20, bottom: 30),
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xff0017FF).withAlpha(135),
              shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30)
              )
            )),
            onPressed: (reservaFormState.checkHoras(horaEntrada, horaSalida) || listaAsientoToReserva.isEmpty) ? null : () {
              showDialog(
                context: context, 
                builder: (context) {
                  return AlertDialog.adaptive(
                    title: Center(child: Text('Reserva', style: textStyle.bodyLarge,),),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Center(child: Text('Lista de asientos a reservar:\n')),
                        Center(child: Text(listaAsientoToReserva.toString())),
                        Center(child: Text('\nhora de entrada: $horaEntrada')),
                        Center(child: Text('hora de salida: $horaSalida')),
                      ],
                    ),
                    actions: [
                      
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(), 
                              child: Text('Cancelar', style: GoogleFonts.montserratAlternates().copyWith(
                                color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold
                              ))
                            ),
                            TextButton(
                              onPressed: () {

                                for (var asiento in listaAsientoToReserva) {
                                  asiento.setHoraEntrada = horaEntrada;
                                  asiento.setHoraSalida = horaSalida;
                                }

                                final newReserva = Reserva(
                                  fecha: _dateController.text,
                                  horaEntrada: horaEntrada!, 
                                  horaSalida: horaSalida!,
                                  nombreAula: widget.aula.nombreAula,
                                  idEscuela: widget.aula.idEscuela,
                                  asientos: listaAsientoToReserva, 
                                );
                                reservaFormState.postReserva(newReserva);
                                Navigator.of(context).pop();

                              }, 
                              child: Text('Aceptar', style: GoogleFonts.montserratAlternates().copyWith(
                                color: Colors.green.shade700, fontSize: 15, fontWeight: FontWeight.bold
                              ))
                            )
                          ],
                        ),
                      )

                    ],
                  );
                },
              );
            }, 
            child: Text('Reservar', style: textStyle.titleMedium,)
          ),
        )
    
      ],
    );
  } 

  Future<void> _selectDate() async{
    DateTime? fecha = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2023), 
      lastDate: DateTime(2100)
    );

    if (fecha != null) {
      setState(() {
        _dateController.text = fecha.toString().split(' ')[0];
      });
    }
  }


  int stringNum(String hora){
    if (hora.isEmpty) hora = '17:00';
    String horaFinal = hora.replaceAll(':', '');
    int numFinal = int.parse(horaFinal);
    return numFinal;
  }

}

class _ButtonAsiento extends StatelessWidget {
  const _ButtonAsiento({this.colorButton, this.onPressed, required this.isSelected});

  final Color? colorButton;
  final VoidCallback? onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: IconButton.filledTonal(
        onPressed: onPressed, 
        icon: const Icon(Icons.chair_outlined), 
        selectedIcon: const Icon(Icons.chair),
        isSelected: isSelected,
        color: colorButton,
        disabledColor: colorButton,
      ),
    );
  }
}