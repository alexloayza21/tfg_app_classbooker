import 'package:image_picker/image_picker.dart';
import 'package:tfg_app/features/shared/widgets/services/camera_gallery_service.dart';

class CameraGalleryServiceImpl extends CameraGalleryService {

  final ImagePicker _picker = ImagePicker();

  @override
  Future<String?> selectPhoto() async{
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);

    if ( photo == null) return null;

    return photo.path;
  }
  
}