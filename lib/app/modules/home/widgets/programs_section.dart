import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/reveal_on_scroll.dart';
import '../../../data/models/program_model.dart';
import '../controllers/home_controller.dart';

class ProgramsSection extends StatelessWidget {
  const ProgramsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();
    final isDesktop = Responsive.isDesktop(context);
    final gutter = Responsive.gutter(context);

    return Container(
      key: c.programsKey,
      color: AppColors.concrete,
      padding: EdgeInsets.symmetric(horizontal: gutter, vertical: isDesktop ? 100 : 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RevealOnScroll(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('THREE FLOORS', style: AppTextStyles.eyebrow()),
                      const SizedBox(height: 16),
                      Text('Pick a floor.\nCoaches run all three.',
                          style: AppTextStyles.headline(size: isDesktop ? 44 : 32)),
                    ],
                  ),
                ),
                if (isDesktop)
                  SizedBox(
                    width: 340,
                    child: Text(
                      'Membership covers every floor — most members move between all '
                      'three depending on the week.',
                      style: AppTextStyles.body(size: 15),
                      textAlign: TextAlign.right,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: isDesktop ? 56 : 40),
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < c.programs.length; i++) ...[
                      if (i != 0) const SizedBox(width: 24),
                      Expanded(
                        child: RevealOnScroll(
                          delay: Duration(milliseconds: i * 110),
                          child: _ProgramCard(program: c.programs[i]),
                        ),
                      ),
                    ],
                  ],
                )
              : Column(
                  children: [
                    for (var i = 0; i < c.programs.length; i++) ...[
                      RevealOnScroll(
                        delay: Duration(milliseconds: i * 90),
                        child: _ProgramCard(program: c.programs[i]),
                      ),
                      if (i != c.programs.length - 1) const SizedBox(height: 28),
                    ],
                  ],
                ),
        ],
      ),
    );
  }
}

class _ProgramCard extends StatefulWidget {
  const _ProgramCard({required this.program});
  final ProgramModel program;

  @override
  State<_ProgramCard> createState() => _ProgramCardState();
}

class _ProgramCardState extends State<_ProgramCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.program;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        color: AppColors.surface,
        transform: Matrix4.translationValues(0, _hover ? -6 : 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      AppColors.concrete.withOpacity(_hover ? 0.05 : 0.28),
                      BlendMode.darken,
                    ),
                    child: Image.network(
                      p.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stack) => Container(color: AppColors.surfaceAlt),
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  top: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: AppColors.caution,
                    child: Text(p.code, style: AppTextStyles.dataSmall(color: AppColors.onCaution, size: 11.5)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.name, style: AppTextStyles.titleCard(size: 24)),
                  const SizedBox(height: 4),
                  Text(p.tagline, style: AppTextStyles.body(color: AppColors.caution, size: 14, weight: FontWeight.w600)),
                  const SizedBox(height: 14),
                  Text(p.description, style: AppTextStyles.body(size: 14.5)),
                  const SizedBox(height: 18),
                  for (final d in p.details) ...[
                    _DetailRow(text: d),
                    const SizedBox(height: 8),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Container(width: 5, height: 5, color: AppColors.fog),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: AppTextStyles.body(size: 13.5))),
      ],
    );
  }
}
