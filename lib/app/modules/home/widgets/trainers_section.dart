import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/reveal_on_scroll.dart';
import '../../../data/models/trainer_model.dart';
import '../controllers/home_controller.dart';

class TrainersSection extends StatelessWidget {
  const TrainersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();
    final isDesktop = Responsive.isDesktop(context);
    final gutter = Responsive.gutter(context);

    return Container(
      key: c.trainersKey,
      color: AppColors.surface,
      padding: EdgeInsets.symmetric(horizontal: gutter, vertical: isDesktop ? 100 : 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RevealOnScroll(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('THE COACHES', style: AppTextStyles.eyebrow()),
                const SizedBox(height: 16),
                Text('Every floor has\nsomeone watching form.',
                    style: AppTextStyles.headline(size: isDesktop ? 44 : 32)),
              ],
            ),
          ),
          SizedBox(height: isDesktop ? 56 : 40),
          !isDesktop
              ? Column(
                  children: [
                    for (var i = 0; i < c.trainers.length; i++) ...[
                      RevealOnScroll(
                        delay: Duration(milliseconds: i * 90),
                        child: _TrainerCard(trainer: c.trainers[i]),
                      ),
                      if (i != c.trainers.length - 1) const SizedBox(height: 24),
                    ],
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < c.trainers.length; i++) ...[
                      if (i != 0) const SizedBox(width: 24),
                      Expanded(
                        child: RevealOnScroll(
                          delay: Duration(milliseconds: i * 110),
                          child: _TrainerCard(trainer: c.trainers[i]),
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

class _TrainerCard extends StatelessWidget {
  const _TrainerCard({required this.trainer});
  final TrainerModel trainer;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.concrete,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Image.network(
              trainer.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stack) => Container(color: AppColors.surfaceAlt),
            ),
          ),
          Container(height: 3, color: AppColors.rust),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(trainer.name, style: AppTextStyles.titleCard(size: 20)),
                const SizedBox(height: 3),
                Text(trainer.role, style: AppTextStyles.dataSmall(color: AppColors.caution, size: 12)),
                const SizedBox(height: 12),
                Text(trainer.bio, style: AppTextStyles.body(size: 13.5)),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: trainer.specialties
                      .map((s) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(border: Border.all(color: AppColors.hairlineStrong)),
                            child: Text(s, style: AppTextStyles.caption(color: AppColors.fog)),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
