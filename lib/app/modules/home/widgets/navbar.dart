import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../controllers/home_controller.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();
    final isDesktop = Responsive.isDesktop(context);

    return Obx(() {
      final solid = c.scrolledPastHero.value;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        color: solid ? AppColors.concrete.withOpacity(0.97) : Colors.transparent,
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.gutter(context),
          vertical: isDesktop ? 20 : 16,
        ),
        child: Row(
          children: [
            _Wordmark(onTap: () => c.scrollTo(c.heroKey)),
            const Spacer(),
            if (isDesktop) ..._desktopLinks(c) else _MobileMenuButton(controller: c),
          ],
        ),
      );
    });
  }

  List<Widget> _desktopLinks(HomeController c) {
    return [
      _NavLink('Programs', () => c.scrollTo(c.programsKey)),
      _NavLink('Coaches', () => c.scrollTo(c.trainersKey)),
      _NavLink('Gallery', () => c.scrollTo(c.galleryKey)),
      _NavLink('Membership', () => c.scrollTo(c.pricingKey)),
      const SizedBox(width: 8),
      _CtaButton(onTap: () => c.scrollTo(c.contactKey)),
    ];
  }
}

class _Wordmark extends StatelessWidget {
  const _Wordmark({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 22,
            color: AppColors.caution,
          ),
          const SizedBox(width: 10),
          Text(
            'STRONGHOLD',
            style: AppTextStyles.titleCard(size: 20).copyWith(letterSpacing: 0.5),
          ),
        ],
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  const _NavLink(this.label, this.onTap);
  final String label;
  final VoidCallback onTap;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            widget.label,
            style: AppTextStyles.dataSmall(
              color: _hover ? AppColors.bone : AppColors.fog,
              size: 13,
            ).copyWith(letterSpacing: 1.4),
          ),
        ),
      ),
    );
  }
}

class _CtaButton extends StatefulWidget {
  const _CtaButton({required this.onTap});
  final VoidCallback onTap;

  @override
  State<_CtaButton> createState() => _CtaButtonState();
}

class _CtaButtonState extends State<_CtaButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          color: _hover ? AppColors.bone : AppColors.caution,
          child: Text('JOIN THE FLOOR', style: AppTextStyles.button()),
        ),
      ),
    );
  }
}

class _MobileMenuButton extends StatelessWidget {
  const _MobileMenuButton({required this.controller});
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.toggleMobileMenu,
      child: Obx(() => Icon(
            controller.mobileMenuOpen.value ? Icons.close : Icons.menu,
            color: AppColors.bone,
            size: 28,
          )),
    );
  }
}

/// Full-bleed mobile nav overlay, shown/hidden by [HomeController.mobileMenuOpen].
class MobileMenuOverlay extends StatelessWidget {
  const MobileMenuOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();
    return Obx(() {
      if (!c.mobileMenuOpen.value) return const SizedBox.shrink();
      return Positioned.fill(
        child: Container(
          color: AppColors.concrete,
          padding: EdgeInsets.symmetric(horizontal: Responsive.gutter(context), vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: c.closeMobileMenu,
                    child: const Icon(Icons.close, color: AppColors.bone, size: 28),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              _MobileLink('Programs', () => c.scrollTo(c.programsKey)),
              _MobileLink('Coaches', () => c.scrollTo(c.trainersKey)),
              _MobileLink('Gallery', () => c.scrollTo(c.galleryKey)),
              _MobileLink('Membership', () => c.scrollTo(c.pricingKey)),
              _MobileLink('Contact', () => c.scrollTo(c.contactKey)),
            ],
          ),
        ),
      );
    });
  }
}

class _MobileLink extends StatelessWidget {
  const _MobileLink(this.label, this.onTap);
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Text(label, style: AppTextStyles.headline(size: 30)),
      ),
    );
  }
}
