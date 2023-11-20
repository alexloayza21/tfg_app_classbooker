import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';

class ReservasCard extends StatelessWidget {
  const ReservasCard({super.key, required this.id,  this.username, this.nombreEscuela, this.fecha, this.horaEntrada, this.horaSalida, this.nombreAula, this.asientos, this.onPressed, });

  final String id;
  final String? fecha;
  final String? horaEntrada;
  final String? horaSalida;
  final String? nombreAula; 
  final String? username;
  final String? nombreEscuela; 
  final List<Asiento>? asientos;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {

    List images = [
      'assets/images/reservationCardImage(1).png',
      'assets/images/reservationCardImage(2).png',
      'assets/images/reservationCardImage(3).png',
      'assets/images/reservationCardImage(4).png'
      ];

    final random = Random();
    final textStyle = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Container(
          height: 180, 
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              colorFilter: const ColorFilter.mode(Colors.black38, BlendMode.hardLight),
              fit: BoxFit.cover,
              image: AssetImage(images[random.nextInt(4)]),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(7,7)
              )
            ]
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (username != null) ? 'Nombre del Usuario: $username' : 'Nombre de Escuela: $nombreEscuela',
                  style: textStyle.titleLarge,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                
                Text(
                  '$nombreAula \nAsientos: $asientos',
                  style: textStyle.titleMedium,
                  textAlign: TextAlign.center,
                ),
                
                Text(
                  'Hora: {$horaEntrada - $horaSalida}, Fecha: $fecha',
                  style: textStyle.titleMedium,
                )
              ],
            ),
          ),
        ),
        onTap: () {
          showDialog(
            context: context, 
            builder: (context) {
              return AlertDialog.adaptive(
                title: Center(child: Text((username != null) ? '$username' : '$nombreEscuela', style: textStyle.bodyLarge,)),
                content: Text(
                  '$nombreAula\n'
                  'Asientos: $asientos\n'
                  'Hora entrada: $horaEntrada\n'
                  'Hora salida: $horaSalida\n'
                  'Fecha: $fecha',
                  textAlign: TextAlign.center,
                ),
                actions: [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: username!= null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: onPressed, 
                          child: Text('Eliminar', style: GoogleFonts.montserratAlternates().copyWith(
                            color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold
                          ))
                        ),

                        username != null ?
                        TextButton(
                          onPressed: onPressed, 
                          child: Text('Confirmar', style: GoogleFonts.montserratAlternates().copyWith(
                            color: Colors.green, fontSize: 15, fontWeight: FontWeight.bold
                          ))
                        )
                        : Container()
                        ,
                      ],
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}