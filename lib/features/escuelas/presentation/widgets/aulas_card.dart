import 'package:flutter/material.dart';
import 'package:tfg_app/features/escuelas/domain/domain.dart';

class AulaGridCard extends StatelessWidget {
  const AulaGridCard({super.key, required this.aula});

  final Aula aula;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _AulaGridCardView(aula: aula,),
    );
  }
}

class _AulaGridCardView extends StatelessWidget {
  const _AulaGridCardView({
    required this.aula,
  });

  final Aula aula;

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme;

    return Container(
      height: 160,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: const DecorationImage(
          colorFilter: ColorFilter.mode(Colors.black38, BlendMode.hardLight),
          fit: BoxFit.cover,
          image: AssetImage('assets/images/classroom.jpg')),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(7,7)
            )
          ]
      ),
      child: Center(
        child: Text(
          'Aula ${aula.nombreAula}', 
          style: textStyle.titleLarge,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ),
    );
  }
}