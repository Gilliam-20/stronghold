import 'package:get/get.dart';
import '../../../data/repositories/contact_repository.dart';
import '../../../data/repositories/gym_repository.dart';
import '../../../data/services/api_service.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GymRepository>(() => GymRepository());
    Get.lazyPut<ContactRepository>(() => ContactRepository(Get.find<ApiService>()));
    Get.lazyPut<HomeController>(
      () => HomeController(Get.find<GymRepository>(), Get.find<ContactRepository>()),
    );
  }
}
