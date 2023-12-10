import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tfg_app/features/auth/presentation/providers/escuela_provider.dart';
import 'package:tfg_app/features/auth/presentation/providers/forms/escuela_post_form_provider.dart';
import 'package:tfg_app/features/auth/presentation/widgets/widgets.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';
import 'package:tfg_app/features/shared/widgets/services/camera_gallery_service_impl.dart';

class EscuelaPostScreen extends ConsumerWidget {
  const EscuelaPostScreen({super.key, required this.escuelaId});

  final String escuelaId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final escuelaState = ref.watch(escuelaProvider(escuelaId));
    final escuela = escuelaState.escuela;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Escuela'),
        centerTitle: true,
      ),
      body: (escuela == null || escuelaState.isLoading) ? const Center(child: CircularProgressIndicator(),) : _EscuelaView(escuela: escuela)
    );
  }
}

class _EscuelaView extends ConsumerWidget {
  const _EscuelaView({
    required this.escuela,
  });

  final Escuela escuela;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final escuelaForm = ref.watch(escuelaPostFormProvider(escuela));


    return SingleChildScrollView(
      child: Column(
        children: [
    
          GestureDetector(
            onTap: () async {
              final photoPath = await CameraGalleryServiceImpl().selectPhoto();
              if (photoPath == null) return;
              ref.read(escuelaPostFormProvider(escuela).notifier).updateEscuelaImage(photoPath);
              photoPath;
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
            onChanged: ref.watch(escuelaPostFormProvider(escuela).notifier).onNombreEscuelaChanged,
          ),
    
          CustomFormField(
            label: 'Dirección',
            initialValue: escuelaForm.direccion,
            onChanged: ref.watch(escuelaPostFormProvider(escuela).notifier).onDireccionChanged,
          ),
    
          CustomFormField(
            label: 'Ciudad',
            initialValue: escuelaForm.ciudad,
            onChanged: ref.watch(escuelaPostFormProvider(escuela).notifier).onCiudadChanged,
          ),
    
          CustomFormField(
            label: 'Provincia',
            initialValue: escuelaForm.provincia,
            onChanged: ref.watch(escuelaPostFormProvider(escuela).notifier).onProvinciaChanged,
          ),
      
          CustomFormField(
            isBottomField: true,
            label: 'Código Postal',
            initialValue: escuelaForm.codigoPostal,
            keyboardType: TextInputType.number,
            onChanged: ref.watch(escuelaPostFormProvider(escuela).notifier).onCodigoPostalChanged,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
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
                  onPressed: ()  {
                    ref.read(escuelaPostFormProvider(escuela).notifier).onFormSubmit()
                    .then((value) {
                      if (!value) return;
                      showSnackbar(context);
                      Future.delayed(const Duration(seconds: 1));
                    });
                    // GoRouter.of(context).pop();
                    GoRouter.of(context).push('/adminHome');
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

  void showSnackbar( BuildContext context) {
      final snackBar = SnackBar(
        padding: const EdgeInsets.all(20),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Create Escuela',
          message: 'Escuela Creada Correctamente',
          contentType: ContentType.success
        )
      );
      ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
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