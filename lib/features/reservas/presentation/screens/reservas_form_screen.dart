import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';
import 'package:tfg_app/features/reservas/presentation/providers/reservas_form_provider.dart';

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

class _ReservasView extends StatefulWidget {
  const _ReservasView({
    required this.aula,
  });

  final Aula aula;

  @override
  State<_ReservasView> createState() => _ReservasViewState();
}

class _ReservasViewState extends State<_ReservasView> {

  final TextEditingController _dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
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

        Expanded(
          child: MasonryGridView.count(
            itemCount: widget.aula.asientos.length,
            crossAxisCount: 4, 
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(4),
                child: GestureDetector(
                  child: IconButton.outlined(
                    onPressed: null, 
                    icon: Icon(Icons.chair_outlined)
                  ),
                ),
              );
            },
          ),
        ),

      ],
    );
  }

  Future<void> _selectDate() async{
    DateTime? _fecha = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2023), 
      lastDate: DateTime(2100)
    );

    if (_fecha != null) {
      setState(() {
        _dateController.text = _fecha.toString().split(' ')[0];
      });
    }
  }

}