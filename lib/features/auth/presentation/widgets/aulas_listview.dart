import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';

class AulasListView extends StatelessWidget {
  const AulasListView({
    super.key, required this.aulas,
  });

  final List<Aula> aulas;

  @override
  Widget build(BuildContext context) {
    return aulas.isEmpty 
      ? GestureDetector(
        child: Container(
          height: 200,
          width: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black45,
                offset: Offset(5, 5)
              )
            ],
            image: const DecorationImage(image: AssetImage('assets/images/classroom.jpg'), fit: BoxFit.cover)
          ),
          
        ),
        onTap: () {
          if (aulas.isEmpty) {
            context.push('/aula/new');
          }else{
            for (var i = 0; i < aulas.length; i++) {
              context.push('/aula/${aulas[i].idAula}');
            }
          }
        }
      )
      : Expanded(
        child: ListView.builder(
          itemCount: aulas.length,
          itemBuilder: (context, index) {
            return _Slider(aula: aulas[index],);
          },
        )
      );
  }
}

class _Slider extends StatelessWidget {
  const _Slider({
    required this.aula,
  });

  final Aula aula;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ClipRRect(
        child: Image.asset('assets/images/clasroom.jpg'),
      ),
    );
  }
}