import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/reveal_on_scroll.dart';
import '../../../data/models/testimonial_model.dart';
import '../controllers/home_controller.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();
    final isDesktop = Responsive.isDesktop(context);
    final gutter = Responsive.gutter(context);

    return Container(
      color: AppColors.concrete,
      padding: EdgeInsets.symmetric(horizontal: gutter, vertical: isDesktop ? 100 : 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RevealOnScroll(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('FROM THE FLOOR', style: AppTextStyles.eyebrow()),
                const SizedBox(height: 16),
                Text('Members, not actors.',
                    style: AppTextStyles.headline(size: isDesktop ? 44 : 32)),
              ],
            ),
          ),
          SizedBox(height: isDesktop ? 56 : 40),
          !isDesktop
              ? Column(
                  children: [
                    for (var i = 0; i < c.testimonials.length; i++) ...[
                      RevealOnScroll(
                        delay: Duration(milliseconds: i * 90),
                        child: _TestimonialCard(testimonial: c.testimonials[i]),
                      ),
                      if (i != c.testimonials.length - 1) const SizedBox(height: 20),
                    ],
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < c.testimonials.length; i++) ...[
                      if (i != 0) const SizedBox(width: 24),
                      Expanded(
                        child: RevealOnScroll(
                          delay: Duration(milliseconds: i * 110),
                          child: _TestimonialCard(testimonial: c.testimonials[i]),
                        ),
                      ),
                    ],
                  ],
                ),
        ],
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  const _TestimonialCard({required this.testimonial});
  final TestimonialModel testimonial;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.all(26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('"', style: AppTextStyles.display(color: AppColors.caution, size: 56)),
          Transform.translate(
            offset: const Offset(0, -22),
            child: Text(
              testimonial.quote,
              style: AppTextStyles.body(color: AppColors.bone, size: 15.5),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              ClipOval(
                child: Image.network(
                  testimonial.imageUrl,
                  width: 44,
                  height: 44,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stack) => Container(
                    width: 44,
                    height: 44,
                    color: AppColors.surfaceAlt,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(testimonial.name, style: AppTextStyles.bodyStrong(size: 14.5)),
                  Text(testimonial.detail, style: AppTextStyles.caption()),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
