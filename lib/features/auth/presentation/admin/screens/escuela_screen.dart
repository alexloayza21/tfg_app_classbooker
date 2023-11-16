import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tfg_app/features/auth/presentation/providers/escuela_provider.dart';
import 'package:tfg_app/features/auth/presentation/providers/forms/escuela_form_provider.dart';
import 'package:tfg_app/features/auth/presentation/widgets/widgets.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';
import 'package:tfg_app/features/shared/widgets/services/camera_gallery_service_impl.dart';

class EscuelaScreen extends ConsumerWidget {
  const EscuelaScreen({super.key, required this.escuelaId});

  final String escuelaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final escuelaState = ref.watch(escuelaProvider(escuelaId));

    // if (escuelaState.escuela == null) {
    //   return const Scaffold(
    //     body: Center(child: CircularProgressIndicator(),),
    //   );
    // }

    final escuela = escuelaState.escuela;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Escuela'),
        centerTitle: true,
      ),
      body: (escuela == null) ? const Center(child: CircularProgressIndicator(),) : _EscuelaView(escuela: escuela)
    );
  }
}

class _EscuelaView extends ConsumerStatefulWidget {
  const _EscuelaView({
    required this.escuela,
  });

  final Escuela escuela;

  @override
  _NewEscuelaViewState createState() => _NewEscuelaViewState();
}

class _NewEscuelaViewState extends ConsumerState<_EscuelaView> with TickerProviderStateMixin{
  
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final escuelaForm = ref.watch(escuelaFormProvider(widget.escuela));


    return SingleChildScrollView(
      child: Column(
        children: [
    
          GestureDetector(
            onTap: () async {
              final photoPath = await CameraGalleryServiceImpl().selectPhoto();
              if (photoPath == null) return;
              ref.read(escuelaFormProvider(widget.escuela).notifier).updateEscuelaImage(photoPath);
              photoPath;
              print(photoPath);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:8, vertical: 20),
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 20,
                      offset: Offset(6, 6) 
                    )
                  ]
                ),
                child: _ImageSelector(image: escuelaForm.imagen,),
              ),
            ),
          ),
      
          CustomFormField(
            isTopField: true,
            label: 'Nombre Escuela',
            initialValue: escuelaForm.nombreEscuela,
            onChanged: ref.watch(escuelaFormProvider(widget.escuela).notifier).onNombreEscuelaChanged,
          ),
    
          CustomFormField(
            label: 'Dirección',
            initialValue: escuelaForm.direccion,
            onChanged: ref.watch(escuelaFormProvider(widget.escuela).notifier).onDireccionChanged,
          ),
    
          CustomFormField(
            label: 'Ciudad',
            initialValue: escuelaForm.ciudad,
            onChanged: ref.watch(escuelaFormProvider(widget.escuela).notifier).onCiudadChanged,
          ),
    
          CustomFormField(
            label: 'Provincia',
            initialValue: escuelaForm.provincia,
            onChanged: ref.watch(escuelaFormProvider(widget.escuela).notifier).onProvinciaChanged,
          ),
      
          CustomFormField(
            isBottomField: true,
            label: 'Código Postal',
            initialValue: escuelaForm.codigoPostal,
            keyboardType: TextInputType.number,
            onChanged: ref.watch(escuelaFormProvider(widget.escuela).notifier).onCodigoPostalChanged,
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 10, left: 5),
                      child: Text('Aulas', style: TextStyle(fontSize: 20),),
                    ),
                    AulasListView(aulas: widget.escuela.aulas!,)
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(30.0),
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
                  onPressed: () {
                    ref.read(escuelaFormProvider(widget.escuela).notifier).onFormSubmit();
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
}

class _ImageSelector extends StatelessWidget {
  const _ImageSelector({ 
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    if (image == '') {
      return ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.asset('assets/images/no-image.jpg', fit: BoxFit.cover,),
      );
    }

    late ImageProvider imageProvider;
    if (image.startsWith('http')) {
      imageProvider = NetworkImage(image);
    }else{
      imageProvider = FileImage(File(image));
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: FadeInImage(
        placeholder: const AssetImage('assets/loaders/bottle-loader.gif'), 
        image: imageProvider,
        fit: BoxFit.cover,
      ),
    );
  }
}