import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/reveal_on_scroll.dart';
import '../controllers/home_controller.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();
    final isDesktop = Responsive.isDesktop(context);
    final gutter = Responsive.gutter(context);

    final info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('VISIT THE FLOOR', style: AppTextStyles.eyebrow()),
        const SizedBox(height: 16),
        Text('Come see it\nbefore you join.', style: AppTextStyles.headline(size: isDesktop ? 40 : 30)),
        const SizedBox(height: 28),
        const _InfoRow(label: 'ADDRESS', value: 'Peponi Road, Westlands\nNairobi, Kenya'),
        const SizedBox(height: 20),
        const _InfoRow(label: 'HOURS', value: 'Mon – Sat: 05:30 – 22:00\nSunday: 08:00 – 18:00'),
        const SizedBox(height: 20),
        _InfoRow(
          label: 'PHONE',
          value: '+254 700 123 456',
          onTap: () => launchUrl(Uri.parse('tel:+254700123456')),
        ),
        const SizedBox(height: 20),
        _InfoRow(
          label: 'EMAIL',
          value: 'floor@stronghold.example.com',
          onTap: () => launchUrl(Uri.parse('mailto:floor@stronghold.example.com')),
        ),
      ],
    );

    final form = Container(
      color: AppColors.surface,
      padding: const EdgeInsets.all(32),
      child: Form(
        key: c.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SEND AN ENQUIRY', style: AppTextStyles.eyebrow(size: 12)),
            const SizedBox(height: 20),
            _Field(label: 'Name', controller: c.nameController, validator: _required),
            const SizedBox(height: 18),
            _Field(label: 'Email', controller: c.emailController, validator: _validateEmail, keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 18),
            _Field(label: 'Phone', controller: c.phoneController, validator: _required, keyboardType: TextInputType.phone),
            const SizedBox(height: 18),
            Text('INTERESTED IN', style: AppTextStyles.dataSmall(size: 11.5)),
            const SizedBox(height: 8),
            Obx(() => Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ['Strength', 'Conditioning', 'Open Floor', 'Not sure yet']
                      .map((option) => _InterestChip(
                            label: option,
                            selected: c.selectedInterest.value == option,
                            onTap: () => c.selectedInterest.value = option,
                          ))
                      .toList(),
                )),
            const SizedBox(height: 18),
            _Field(label: 'Message (optional)', controller: c.messageController, maxLines: 3),
            const SizedBox(height: 24),
            Obx(() => _SubmitButton(state: c.submitState.value, onTap: c.submitEnquiry)),
            Obx(() {
              if (c.submitState.value != SubmitState.success) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Text(
                  'Thanks — a coach will get back to you within a day.',
                  style: AppTextStyles.body(color: AppColors.success, size: 13.5),
                ),
              );
            }),
          ],
        ),
      ),
    );

    return Container(
      key: c.contactKey,
      color: AppColors.concrete,
      padding: EdgeInsets.symmetric(horizontal: gutter, vertical: isDesktop ? 100 : 64),
      child: RevealOnScroll(
        child: isDesktop
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 5, child: info),
                  const SizedBox(width: 64),
                  Expanded(flex: 6, child: form),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  info,
                  const SizedBox(height: 44),
                  form,
                ],
              ),
      ),
    );
  }

  static String? _required(String? v) => (v == null || v.trim().isEmpty) ? 'Required' : null;

  static String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Required';
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim());
    return ok ? null : 'Enter a valid email';
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value, this.onTap});
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.dataSmall(size: 11.5)),
        const SizedBox(height: 6),
        Text(value, style: AppTextStyles.body(color: AppColors.bone, size: 15)),
      ],
    );
    if (onTap == null) return content;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(onTap: onTap, child: content),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
  });

  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: AppTextStyles.body(color: AppColors.bone, size: 15),
      cursorColor: AppColors.caution,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyles.dataSmall(size: 12),
        floatingLabelStyle: AppTextStyles.dataSmall(color: AppColors.caution, size: 12),
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.hairlineStrong)),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.caution, width: 1.4)),
        errorBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.error)),
        errorStyle: AppTextStyles.caption(color: AppColors.error),
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
      ),
    );
  }
}

class _InterestChip extends StatelessWidget {
  const _InterestChip({required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        color: selected ? AppColors.caution : Colors.transparent,
        child: Text(
          label,
          style: AppTextStyles.dataSmall(
            color: selected ? AppColors.onCaution : AppColors.fog,
            size: 12,
          ),
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({required this.state, required this.onTap});
  final SubmitState state;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final submitting = state == SubmitState.submitting;
    return GestureDetector(
      onTap: submitting ? null : onTap,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 17),
        color: AppColors.caution,
        child: submitting
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.onCaution),
              )
            : Text('SEND ENQUIRY', style: AppTextStyles.button()),
      ),
    );
  }
}
