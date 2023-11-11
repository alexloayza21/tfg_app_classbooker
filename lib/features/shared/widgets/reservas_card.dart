import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';

class ReservasCard extends StatelessWidget {
  const ReservasCard({super.key, required this.reserva});

  final Reserva reserva;

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
      child: Container(
        height: 150, 
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
                'Nombre del Usuario: ${reserva.user!.username}',
                style: textStyle.titleLarge,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              
              Text(
                'Asientos: ${reserva.asientos}',
                style: textStyle.titleMedium,
              ),
              
              Text(
                '${reserva.horaEntrada} - ${reserva.horaSalida}',
                style: textStyle.titleMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}