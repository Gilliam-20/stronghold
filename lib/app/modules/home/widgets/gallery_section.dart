import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/gym_images.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/reveal_on_scroll.dart';
import '../controllers/home_controller.dart';

class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

  static const List<String> _labels = [
    'STRENGTH FLOOR',
    'LOADED & READY',
    'CONDITIONING',
    'OPEN FLOOR',
    'PLATES, RACKED',
    'FLOOR DETAIL',
  ];

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);
    final gutter = Responsive.gutter(context);

    final images = [
      GymImages.hero,
      GymImages.galleryPlates,
      GymImages.conditioning,
      GymImages.interiorWide,
      GymImages.strength,
      GymImages.galleryMono,
    ];
    final labels = _labels;

    final crossCount = isMobile ? 2 : 3;

    return Container(
      key: c.galleryKey,
      color: AppColors.concrete,
      padding: EdgeInsets.symmetric(horizontal: gutter, vertical: isDesktop ? 100 : 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RevealOnScroll(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ON THE FLOOR', style: AppTextStyles.eyebrow()),
                const SizedBox(height: 16),
                Text('What a session\nactually looks like.',
                    style: AppTextStyles.headline(size: isDesktop ? 44 : 32)),
              ],
            ),
          ),
          SizedBox(height: isDesktop ? 48 : 36),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: images.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: isMobile ? 0.8 : 0.95,
            ),
            itemBuilder: (context, i) {
              return RevealOnScroll(
                delay: Duration(milliseconds: (i % 3) * 90),
                child: _GalleryTile(url: images[i], label: labels[i]),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _GalleryTile extends StatefulWidget {
  const _GalleryTile({required this.url, required this.label});
  final String url;
  final String label;

  @override
  State<_GalleryTile> createState() => _GalleryTileState();
}

class _GalleryTileState extends State<_GalleryTile> {
  bool _hover = false;

  // Standard luminance-preserving grayscale matrix.
  static const List<double> _grayscale = <double>[
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0, 0, 0, 1, 0,
  ];

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.basic,
      child: ClipRect(
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedScale(
              duration: const Duration(milliseconds: 280),
              scale: _hover ? 1.06 : 1.0,
              child: ColorFiltered(
                colorFilter: ColorFilter.matrix(_grayscale),
                child: Image.network(
                  widget.url,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stack) => Container(color: AppColors.surfaceAlt),
                ),
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 280),
              opacity: _hover ? 1 : 0,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 280),
                scale: _hover ? 1.06 : 1.0,
                child: Image.network(
                  widget.url,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stack) => Container(color: AppColors.surfaceAlt),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, AppColors.concrete.withOpacity(0.9)],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 28, 14, 12),
                  child: Text(
                    widget.label,
                    style: AppTextStyles.dataSmall(color: AppColors.bone, size: 11.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
