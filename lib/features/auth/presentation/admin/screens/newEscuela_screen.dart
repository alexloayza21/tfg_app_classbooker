import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:tfg_app/features/auth/presentation/widgets/widgets.dart';

class NewEscuelaScreen extends ConsumerWidget {
  const NewEscuelaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Escuela'),
        centerTitle: true,
      ),
      body: const _NewEscuelaView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        }, 
        child: const Icon(Icons.save),
      ),
    );
  }
}

class _NewEscuelaView extends StatefulWidget {
  const _NewEscuelaView({
    super.key,
  });

  @override
  State<_NewEscuelaView> createState() => _NewEscuelaViewState();
}

class _NewEscuelaViewState extends State<_NewEscuelaView> with TickerProviderStateMixin{
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
            decoration: BoxDecoration(
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
              ]),
              child: (_image == null) ? null : LottieBuilder.asset(
                'assets/lottieFiles/checkJson.json',
                controller: _controller,
                onLoaded: (_) {
                  _controller.animateTo(4, duration: Duration(seconds: 6));
                },
              ),
            ),
          ),
      
          const CustomFormField(
            isTopField: true,
            label: 'Nombre',
            initialValue: 'Nombre escuela',
          ),
    
          const CustomFormField(
            label: 'Dirección',
            initialValue: 'Dirección escuela',
          ),
    
          const CustomFormField(
            label: 'Ciudad',
            initialValue: 'Ciudad escuela',
          ),
    
          const CustomFormField(
            label: 'Provincia',
            initialValue: 'Provincia escuela',
          ),
      
          const CustomFormField(
            isBottomField: true,
            label: 'Código Postal',
            initialValue: 'Código Postal escuela',
            keyboardType: TextInputType.number,
          ),
      
        ],
      ),
    );
  }
}