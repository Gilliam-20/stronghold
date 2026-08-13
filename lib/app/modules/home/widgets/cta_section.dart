import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/reveal_on_scroll.dart';
import '../controllers/home_controller.dart';

class CtaSection extends StatelessWidget {
  const CtaSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();
    final isDesktop = Responsive.isDesktop(context);
    final gutter = Responsive.gutter(context);

    return RevealOnScroll(
      child: Container(
        color: AppColors.caution,
        padding: EdgeInsets.symmetric(horizontal: gutter, vertical: isDesktop ? 88 : 56),
        child: Flex(
          direction: isDesktop ? Axis.horizontal : Axis.vertical,
          crossAxisAlignment: isDesktop ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            if (isDesktop)
              Expanded(
                flex: 3,
                child: Text(
                  'FIRST SESSION\nIS ON THE HOUSE.',
                  style: AppTextStyles.display(color: AppColors.onCaution, size: 56),
                ),
              )
            else
              Text(
                'FIRST SESSION\nIS ON THE HOUSE.',
                style: AppTextStyles.display(color: AppColors.onCaution, size: 38),
              ),
            SizedBox(width: isDesktop ? 40 : 0, height: isDesktop ? 0 : 28),
            if (isDesktop) const Spacer(),
            _DarkButton(onTap: () => c.scrollTo(c.contactKey)),
          ],
        ),
      ),
    );
  }
}

class _DarkButton extends StatefulWidget {
  const _DarkButton({required this.onTap});
  final VoidCallback onTap;

  @override
  State<_DarkButton> createState() => _DarkButtonState();
}

class _DarkButtonState extends State<_DarkButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          color: _hover ? AppColors.surface : AppColors.concrete,
          child: Text('CLAIM YOUR SESSION', style: AppTextStyles.button(color: AppColors.bone)),
        ),
      ),
    );
  }
}
