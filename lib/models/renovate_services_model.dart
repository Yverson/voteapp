import 'common_model.dart';
import '../utils/images.dart';

List<CommonModel> renovateServices = getRenovateServices();

List<CommonModel> getRenovateServices() {
  List<CommonModel> renovateServices = [];
  renovateServices.add(CommonModel.withoutIcon("Homme", room,isSelected: true));
  renovateServices.add(CommonModel.withoutIcon("Femme", kitchen,isSelected: false));
  return renovateServices;
}
