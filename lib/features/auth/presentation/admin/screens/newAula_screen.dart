import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tfg_app/features/auth/presentation/widgets/widgets.dart';

class NewAulaScreen extends StatelessWidget {
  const NewAulaScreen({super.key, required this.idAula});

  final String idAula;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Aula'),
        centerTitle: true,
      ),
      body: const _NewEscuelaView(),
    );
  }
}

class _NewEscuelaView extends ConsumerStatefulWidget {
  const _NewEscuelaView({
    super.key,
  });

  @override
  _NewEscuelaViewState createState() => _NewEscuelaViewState();
}

class _NewEscuelaViewState extends ConsumerState<_NewEscuelaView> {

  final _textController = TextEditingController();
  late String horaEntrada = '';
  late String horaSalida = '';
  late String? valor = '';
  late bool cadaHora = false;
  late bool cadaMediaHora = false;

  List<String> opciones = ['media hora', 'hora'];

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [

          const CustomFormField(
            isTopField: true,
            isBottomField: true,
            label: 'Nombre del aula',
            initialValue: 'initial value',
          ),

          const Text('\nHorario'),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Hora de entrada'),                
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
                const Text('Hora de salida'),                
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

          
          const Text('\nHorario de reserva cada:\n'),

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

                  const Text('Hora')
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
    
                  const Text('Media Hora')
                ],
              )

            ],
          ),

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