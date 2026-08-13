import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../controllers/home_controller.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();
    final isDesktop = Responsive.isDesktop(context);
    final gutter = Responsive.gutter(context);
    final floorLinks = _FooterColumn(
      title: 'FLOOR',
      items: const ['Programs', 'Coaches', 'Gallery', 'Membership'],
      onTap: (i) {
        final keys = [c.programsKey, c.trainersKey, c.galleryKey, c.pricingKey];
        c.scrollTo(keys[i]);
      },
    );
    final followLinks = _FooterColumn(
      title: 'FOLLOW',
      items: const ['Instagram', 'TikTok', 'WhatsApp'],
      onTap: (i) {
        const urls = [
          'https://instagram.com/stronghold.ke',
          'https://tiktok.com/@stronghold.ke',
          'https://wa.me/254700123456',
        ];
        launchUrl(Uri.parse(urls[i]), mode: LaunchMode.externalApplication);
      },
    );

    return Container(
      color: AppColors.concreteDeep,
      padding: EdgeInsets.fromLTRB(gutter, isDesktop ? 64 : 44, gutter, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flex(
            direction: isDesktop ? Axis.horizontal : Axis.vertical,
            crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.start,
            children: [
              if (isDesktop)
                const Expanded(flex: 4, child: _FooterBrand())
              else
                const _FooterBrand(),
              SizedBox(height: isDesktop ? 0 : 36, width: isDesktop ? 40 : 0),
              if (isDesktop) Expanded(flex: 3, child: floorLinks) else floorLinks,
              SizedBox(height: isDesktop ? 0 : 28, width: isDesktop ? 24 : 0),
              if (isDesktop) Expanded(flex: 3, child: followLinks) else followLinks,
            ],
          ),
          SizedBox(height: isDesktop ? 56 : 40),
          Container(height: 1, color: AppColors.hairline),
          const SizedBox(height: 22),
          Flex(
            direction: isDesktop ? Axis.horizontal : Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('© 2026 STRONGHOLD ATHLETIC', style: AppTextStyles.caption()),
              if (isDesktop) const Spacer(),
              if (!isDesktop) const SizedBox(height: 8),
              Text('Photography via Unsplash, free license', style: AppTextStyles.caption()),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterBrand extends StatelessWidget {
  const _FooterBrand();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 10, height: 22, color: AppColors.caution),
            const SizedBox(width: 10),
            Text('STRONGHOLD', style: AppTextStyles.titleCard(size: 20)),
          ],
        ),
        const SizedBox(height: 14),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Text(
            'A coached strength floor, boxing-based conditioning, and full '
            'equipment access on Peponi Road, Westlands.',
            style: AppTextStyles.body(size: 13.5),
          ),
        ),
      ],
    );
  }
}

class _FooterColumn extends StatelessWidget {
  const _FooterColumn({required this.title, required this.items, this.onTap});
  final String title;
  final List<String> items;
  final void Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.dataSmall(size: 11.5)),
        const SizedBox(height: 16),
        for (var i = 0; i < items.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: onTap == null ? null : () => onTap!(i),
              child: Text(items[i], style: AppTextStyles.body(color: AppColors.bone, size: 14)),
            ),
          ),
      ],
    );
  }
}
