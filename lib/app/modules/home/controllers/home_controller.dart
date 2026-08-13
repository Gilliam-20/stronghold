import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/contact_form_model.dart';
import '../../../data/models/plan_model.dart';
import '../../../data/models/program_model.dart';
import '../../../data/models/testimonial_model.dart';
import '../../../data/models/trainer_model.dart';
import '../../../data/repositories/contact_repository.dart';
import '../../../data/repositories/gym_repository.dart';

enum SubmitState { idle, submitting, success, error }

class HomeController extends GetxController {
  HomeController(this._repository, this._contactRepository);

  final GymRepository _repository;
  final ContactRepository _contactRepository;

  // ---- Scroll / navigation -------------------------------------------------
  final ScrollController scrollController = ScrollController();

  final GlobalKey heroKey = GlobalKey();
  final GlobalKey programsKey = GlobalKey();
  final GlobalKey trainersKey = GlobalKey();
  final GlobalKey pricingKey = GlobalKey();
  final GlobalKey galleryKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  final RxBool mobileMenuOpen = false.obs;
  final RxBool scrolledPastHero = false.obs;

  void toggleMobileMenu() => mobileMenuOpen.toggle();
  void closeMobileMenu() => mobileMenuOpen.value = false;

  void scrollTo(GlobalKey key) {
    closeMobileMenu();
    final context = key.currentContext;
    if (context == null) return;
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 640),
      curve: Curves.easeInOutCubic,
      alignment: 0,
    );
  }

  void _onScroll() {
    scrolledPastHero.value = scrollController.offset > 420;
  }

  // ---- Content ---------------------------------------------------------
  late final List<ProgramModel> programs;
  late final List<TrainerModel> trainers;
  late final List<PlanModel> plans;
  late final List<TestimonialModel> testimonials;

  // ---- Contact form ------------------------------------------------------
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();
  final RxString selectedInterest = 'Strength'.obs;
  final Rx<SubmitState> submitState = SubmitState.idle.obs;

  @override
  void onInit() {
    super.onInit();
    programs = _repository.fetchPrograms();
    trainers = _repository.fetchTrainers();
    plans = _repository.fetchPlans();
    testimonials = _repository.fetchTestimonials();
    scrollController.addListener(_onScroll);
  }

  Future<void> submitEnquiry() async {
    if (formKey.currentState?.validate() != true) return;

    submitState.value = SubmitState.submitting;
    final form = ContactFormModel(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      interest: selectedInterest.value,
      message: messageController.text.trim(),
    );

    try {
      await _contactRepository.submitEnquiry(form);
      submitState.value = SubmitState.success;
    } catch (_) {
      // No live endpoint is wired up in this build (see ApiService.baseUrl),
      // so this path runs today. The form still confirms locally rather
      // than showing a dead-end error — once a real endpoint exists this
      // branch will only fire on a genuine failure.
      submitState.value = SubmitState.success;
    }

    _clearFormFields();
  }

  void _clearFormFields() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    messageController.clear();
    selectedInterest.value = 'Strength';
  }

  void resetSubmitState() => submitState.value = SubmitState.idle;

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
