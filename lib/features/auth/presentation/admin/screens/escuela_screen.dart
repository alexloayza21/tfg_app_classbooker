import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:tfg_app/features/auth/presentation/providers/escuela_provider.dart';
import 'package:tfg_app/features/auth/presentation/widgets/widgets.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';

class EscuelaScreen extends ConsumerWidget {
  const EscuelaScreen({super.key, required this.escuelaId});

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
      body: _NewEscuelaView(escuela: escuela!)
    );
  }
}

class _NewEscuelaView extends ConsumerStatefulWidget {
  const _NewEscuelaView({
    required this.escuela,
  });

  final Escuela escuela;

  @override
  _NewEscuelaViewState createState() => _NewEscuelaViewState();
}

class _NewEscuelaViewState extends ConsumerState<_NewEscuelaView> with TickerProviderStateMixin{
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
//     _controller.addListener(() {
//       print(_controller.value);
//     //  if the full duration of the animation is 8 secs then 0.5 is 4 secs
//       if (_controller.value > 0.5) {
// // When it gets there hold it there.
//         _controller.value = 0.5;
//       }
//     });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  File? _image;
  late FormData formData = FormData();
  Future _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

    }

    formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(_image!.path),
    });
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: [
    
          Text(formData.toString()),
    
          GestureDetector(
            onTap: _pickImage,
            child: Container(
            height: (_image == null) ? 250 : 100, 
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            decoration: widget.escuela.imagen!.isEmpty ? BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: (_image != null) ? null : const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/no-image.jpg')
              ),
              boxShadow: [
                BoxShadow(
                  color: (_image == null) ? Colors.grey.withOpacity(1) : Colors.white,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0,5)
                )
              ]): BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: (_image != null) ? null : DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.escuela.imagen!)
              ),
              boxShadow: [
                BoxShadow(
                  color: (_image == null) ? Colors.grey.withOpacity(1) : Colors.white,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0,5)
                )
              ]),
              child: (_image == null) ? null : LottieBuilder.asset(
                'assets/lottieFiles/checkJson.json',
                controller: _controller,
                onLoaded: (_) {
                  _controller.animateTo(4, duration: const Duration(seconds: 6));
                },
              ),
            ),
          ),
      
          CustomFormField(
            isTopField: true,
            label: 'Nombre Escuela',
            initialValue: widget.escuela.nombreEscuela,
          ),
    
          CustomFormField(
            label: 'Dirección',
            initialValue: widget.escuela.direccion,
          ),
    
          CustomFormField(
            label: 'Ciudad',
            initialValue: widget.escuela.ciudad,
          ),
    
          CustomFormField(
            label: 'Provincia',
            initialValue: widget.escuela.provincia,
          ),
      
          CustomFormField(
            isBottomField: true,
            label: 'Código Postal',
            initialValue: widget.escuela.codigoPostal,
            keyboardType: TextInputType.number,
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
}