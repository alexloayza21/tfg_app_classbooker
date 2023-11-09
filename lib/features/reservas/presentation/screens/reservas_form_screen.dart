import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';
import 'package:tfg_app/features/reservas/presentation/providers/reservas_form_provider.dart';
import 'package:tfg_app/features/reservas/presentation/providers/reservas_provider.dart';
import 'package:tfg_app/features/reservas/presentation/widgets/widgets.dart';

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
        body:  _ReservasView(aula: reservaFormState.aula!,),
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

  final horasEntrada = ['17:00', '18:00', '19:00', '20:00'];
  final horasSalida = ['18:00', '19:00', '20:00','21:00'];

  String? horaEntrada = '';
  String? horaSalida = '';

  String errorTexto = '';
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    
    final textStyle = Theme.of(context).textTheme;
    final List<Asiento> asientos = widget.aula.asientos;

    final reservasState = ref.watch(reservaProvider(_dateController.text));

    late List<Asiento> asientosResevas = [];

    for (var reserva in reservasState.reservas) {
      for (var asiento in reserva.asientos) {
        if (asiento.idAula == widget.aula.idAula) {
          asientosResevas.add(asiento);
        }
      }
    }

    List<bool> isSelected = List.generate(asientos.length, (index) => false);

    return SingleChildScrollView(
      child: Column(
        children: [
    
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,  vertical: 10),
            child: Column(
              children: [
                Center(child: Text('Fecha de Reserva', style: textStyle.bodyMedium)),
                TextField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    hintText: DateTime.now().toString().split(' ')[0],
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
                      });
                      //TODO: CAMBIAR
                      errorTexto = entradas(horaEntrada!, horaSalida!);
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
                      });
                      //TODO: CAMBIAR
                      errorTexto = entradas(horaEntrada!, horaSalida!);
                    },
                    icon: const Icon(Icons.access_time_outlined),
                    
                  ),
                )
              ],
            ),
          ),
    
          Text(errorTexto),
    
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Wrap(
              children: List.generate(asientos.length, (index) {
                for (var j = 0; j < asientosResevas.length; j++) {
                  
                  if(
                    asientos[index].numeroAsiento == asientosResevas[j].numeroAsiento 
                    && (horaEntrada == asientosResevas[j].horaEntrada && horaSalida == asientosResevas[j].horaSalida)) {
                    return const _ButtonAsiento(
                      colorButton: Colors.red, 
                      onPressed: null,
                      isSelected: false,
                    );
                  }

                  if ((asientos[index].numeroAsiento == asientosResevas[j].numeroAsiento &&
                      stringNum(horaEntrada!) < stringNum(asientosResevas[j].horaEntrada ?? '') && horaSalida == asientosResevas[j].horaSalida
                      )
                    || (asientos[index].numeroAsiento == asientosResevas[j].numeroAsiento &&
                      horaEntrada == asientosResevas[j].horaEntrada && stringNum(horaSalida!) >  stringNum(asientosResevas[j].horaSalida ?? '')
                      )) {
                    return _ButtonAsiento(
                      colorButton: Colors.deepPurple,
                      isSelected: false, 
                      onPressed: () {
                        showDialog(
                          context: context, 
                          builder: (context) {
                            return Dialog();
                          },
                        );
                      }
                    );
                  }
                }

                return _ButtonAsiento(
                  colorButton: Colors.green,
                  isSelected: false,
                  onPressed: (){
                    print(asientos[index].numeroAsiento);
                  },
                ); 
              }),
            ),
          ),
    
          Container(
            width: double.infinity,
            height: 70,
            margin: EdgeInsets.only(right: 20, left: 20, bottom: 30),
            child: FilledButton(
              onPressed: () {
                print('');
                print('${_dateController.text}, $horaEntrada, $horaSalida');
                print('asientosReservas: ${asientosResevas.length}');
                print('reservasState.length ${reservasState.reservas.length}');
                print('');
              }, 
              child: Text('Reservar', style: textStyle.titleMedium,)
            ),
          )
    
        ],
      ),
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

  String entradas (String horaEntrada, String horaSalida) {
    List<String> entrada = horaEntrada.split(':');
    List<String> salida = horaSalida.split(':');

    if (entrada[0].isEmpty) entrada[0] = '0';
    if (salida[0].isEmpty) salida[0] = '0';

    int numEntrada = int.parse(entrada[0]);
    int numSalida = int.parse(salida[0]);

    if (numSalida <= numEntrada) {
      return 'Error';
    }else{
      return 'noError';
    }

  }

  int stringNum(String hora){
    if (hora.isEmpty) hora = '17:00';
    List<String> horaFinal = hora.split(':');
    int numFinal = int.parse(horaFinal[0]);
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
      padding: const EdgeInsets.all(4),
      child: IconButton.filledTonal(
        onPressed: onPressed, 
        icon: const Icon(Icons.chair_outlined), 
        selectedIcon: Icon(Icons.chair),
        isSelected: isSelected,
        color: colorButton,
        disabledColor: colorButton,
      )
    );
  }
}

class MyToggleButtons extends StatefulWidget {

  
  final List<bool> isSelected;
  final List<Asiento> asientos;

  const MyToggleButtons({super.key, required this.isSelected, required this.asientos});

  @override
  _MyToggleButtonsState createState() => _MyToggleButtonsState();
}

class _MyToggleButtonsState extends State<MyToggleButtons> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ToggleButtons(
        isSelected: widget.isSelected,
        onPressed: (int index) {
          setState(() {
            // Cambia el estado del índice seleccionado
            widget.isSelected[index] = !widget.isSelected[index];
          });
        },
        color: Colors.grey,
        selectedColor: Colors.blue,
        fillColor: Colors.blue.withOpacity(0.2),
        borderColor: Colors.blue,
        selectedBorderColor: Colors.blue,
        borderRadius: BorderRadius.circular(10),
        children: widget.asientos.map((e) {
          return Icon(Icons.chair_outlined);
        }).toList(),
      ),
    );
  }
}
