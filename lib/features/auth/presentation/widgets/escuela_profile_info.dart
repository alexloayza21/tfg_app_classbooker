import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tfg_app/features/auth/presentation/providers/escuela_profile_provider.dart';
import 'package:tfg_app/features/reservas/domain/domain.dart';
import 'package:tfg_app/features/reservas/presentation/providers/aulas_provider.dart';
import 'package:tfg_app/features/reservas/presentation/widgets/widgets.dart';

class EscuelaProfileInfo extends ConsumerWidget {
  const EscuelaProfileInfo({super.key, required this.escuela});

  final Escuela? escuela;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final aulasState = ref.watch(aulasProvider(escuela?.idEscuela ?? ''));

    final textStyle = Theme.of(context).textTheme;
    return Expanded(
      child: Column(
        children: [
    
          _EscuelaProfileCard(escuela: escuela, textStyle: textStyle),
    
          Expanded(
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: (aulasState.aulas.isNotEmpty) 
              ? MasonryGridView.count(
                itemCount: aulasState.aulas.length,
                crossAxisCount: 2, 
                itemBuilder: (context, index) {
                  final aula = aulasState.aulas[index];
                  return GestureDetector(
                    child: AulaGridCard(aula: aula),
                    onTap: () => context.push('/adminHome/adminProfile/aula/${aula.idAula}'),
                    onLongPress: () {
                      showDialog(
                        context: context, 
                        builder: (context) {
                          return AlertDialog.adaptive(
                            title: Center(child: Text('Borrar ${aula.nombreAula}', textAlign: TextAlign.center, style: textStyle.bodyLarge,)),
                            actions: [
                              TextButton(
                                onPressed: () async{
                                 await ref.read(aulasProvider(aula.idEscuela).notifier).deleteAula(aula.idAula);
                                 Navigator.pop(context);
                                }, 
                                child: Center(
                                  child: Text('Borrar', style: GoogleFonts.montserratAlternates().copyWith(
                                    color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold
                                  )),
                                )
                              )
                            ],
                          );
                        }
                      );
                    },
                  );
                },
              )
              : const Center(
                child: Text('No tienes aulas 🫠'),
              )
            ),
          ),
        ],
      ),
    );
  }
}

class _EscuelaProfileCard extends StatelessWidget {
  const _EscuelaProfileCard({
    required this.escuela,
    required this.textStyle,
  });

  final Escuela? escuela;
  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/adminHome/adminProfile/escuelaUpdate/${escuela?.idEscuela}');
      },
      onLongPress: () {
        deleteDialog(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: escuela?.imagen == ''
            ? const DecorationImage (
              colorFilter: ColorFilter.mode(Colors.black38, BlendMode.hardLight),
              image: AssetImage('assets/images/no-image.jpg'), 
              fit: BoxFit.cover)
             : DecorationImage (
              colorFilter: const ColorFilter.mode(Colors.black38, BlendMode.hardLight),
              image: NetworkImage(escuela?.imagen ?? ''), 
              fit: BoxFit.cover
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text(escuela?.nombreEscuela ?? '', style: textStyle.titleLarge, textAlign: TextAlign.center,)),
                const Spacer(),
                const Spacer(),
                Expanded(
                  child: Center(
                    child: Text(
                      '🚩 ${escuela?.direccion}, ${escuela?.ciudad}, ${escuela?.provincia}, ${escuela?.codigoPostal} ',
                      textAlign: TextAlign.center,
                      style: textStyle.titleMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> deleteDialog(BuildContext context) {
    return showDialog(
        context: context, 
        builder: (context){
          return _AlertDialogDelete(textStyle: textStyle, escuela: escuela);
        }
      );
  }
}

class _AlertDialogDelete extends ConsumerWidget {
  const _AlertDialogDelete({
    required this.textStyle,
    required this.escuela,
  });

  final TextTheme textStyle;
  final Escuela? escuela;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog.adaptive(
    
      title: Center(child: Text('Borrar escuela', style: textStyle.bodyLarge,)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              '${escuela?.nombreEscuela}'
              '\n${escuela?.direccion}\n${escuela?.ciudad}\n${escuela?.provincia}\n${escuela?.codigoPostal}'
              '\n\nRecuerda que al borrar la escuela, borrarás también todas sus aulas',
              textAlign: TextAlign.center,
            )),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: (){
                ref.read(escuelaProfileProvider(escuela?.userId ?? '').notifier).deleteEscuela(escuela?.idEscuela ?? '')
                .then((value) {
                  if (!value) return;
                  showSnackbar(context);
                  Future.delayed(const Duration(seconds: 1));
                });
                GoRouter.of(context).pop();
                GoRouter.of(context).pushReplacement('/adminHome');
              }, 
              child: Text('Borrar', style:GoogleFonts.montserratAlternates().copyWith(
                color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold
              ))
            )
          ],
        )
      ],
    );
  }

  void showSnackbar( BuildContext context) {
      final snackBar = SnackBar(
        padding: const EdgeInsets.all(20),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Delete Escuela',
          message: 'Escuela Eliminada Correctamente',
          contentType: ContentType.failure
        )
      );
      ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}