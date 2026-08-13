import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/gym_images.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../controllers/home_controller.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();
    final isMobile = Responsive.isMobile(context);
    final gutter = Responsive.gutter(context);
    final screenHeight = MediaQuery.sizeOf(context).height;

    return SizedBox(
      key: c.heroKey,
      width: double.infinity,
      height: isMobile ? 640 : screenHeight.clamp(640.0, 880.0).toDouble(),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            GymImages.hero,
            fit: BoxFit.cover,
            alignment: const Alignment(0.15, -0.2),
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Container(color: AppColors.concrete);
            },
            errorBuilder: (context, error, stack) =>
                Container(color: AppColors.concrete),
          ),
          // Directional scrim — darkest lower-left where the copy sits.
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  AppColors.concrete.withOpacity(0.96),
                  AppColors.concrete.withOpacity(0.55),
                  AppColors.concrete.withOpacity(0.20),
                ],
                stops: const [0.0, 0.55, 1.0],
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(gutter, 96, gutter, 32),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight:
                        (constraints.maxHeight - 128).clamp(0, double.infinity).toDouble(),
                  ),
                  child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('WESTLANDS, NAIROBI  —  EST. 2020',
                    style: AppTextStyles.eyebrow()),
                const SizedBox(height: 18),
                FittedBox(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.scaleDown,
                  child: Text(
                  'STRENGTH\nIS BUILT\nHERE.',
                  style: AppTextStyles.display(size: isMobile ? 52 : 108),
                  ),
                ),
                const SizedBox(height: 22),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: Text(
                    'A coached strength floor, boxing-based conditioning, and full '
                    'equipment access, a short walk from Peponi Road. No contracts, '
                    'no gimmicks — just work.',
                    style: AppTextStyles.body(
                        color: AppColors.bone.withOpacity(0.82), size: 16.5),
                  ),
                ),
                const SizedBox(height: 32),
                Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  children: [
                    _PrimaryButton(
                        label: 'JOIN THE FLOOR',
                        onTap: () => c.scrollTo(c.contactKey)),
                    _GhostButton(
                        label: 'SEE THE PROGRAMS',
                        onTap: () => c.scrollTo(c.programsKey)),
                  ],
                ),
                const SizedBox(height: 40),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    Container(
                        width: 28, height: 1, color: AppColors.hairlineStrong),
                    Text('OPEN 7 DAYS  ·  05:30 – 22:00',
                        style: AppTextStyles.dataSmall()),
                  ],
                ),
              ],
              ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  const _PrimaryButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
          color: _hover ? AppColors.bone : AppColors.caution,
          child: Text(widget.label, style: AppTextStyles.button()),
        ),
      ),
    );
  }
}

class _GhostButton extends StatefulWidget {
  const _GhostButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  State<_GhostButton> createState() => _GhostButtonState();
}

class _GhostButtonState extends State<_GhostButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
          decoration: BoxDecoration(
            border: Border.all(
                color: _hover ? AppColors.bone : AppColors.fog, width: 1.2),
          ),
          child: Text(
            widget.label,
            style: AppTextStyles.button(
                color: _hover ? AppColors.bone : AppColors.fog),
          ),
        ),
      ),
    );
  }
}
