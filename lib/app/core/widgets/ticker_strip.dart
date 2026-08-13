import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// The site's signature device: a continuously scrolling strip painted with
/// diagonal hazard stripes, styled after the loading-zone tape and rack
/// warning labels found on a real gym floor. Used directly under the nav
/// and again as a divider before the CTA band, so both visits bookend the
/// page with the same industrial texture.
class TickerStrip extends StatefulWidget {
  const TickerStrip({
    super.key,
    required this.items,
    this.height = 46,
    this.speed = 40,
  });

  final List<String> items;
  final double height;
  final double speed; // logical pixels per second

  @override
  State<TickerStrip> createState() => _TickerStripState();
}

class _TickerStripState extends State<TickerStrip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(days: 1))
      ..addListener(_tick)
      ..repeat();
  }

  void _tick() {
    if (!_scrollController.hasClients) return;
    final max = _scrollController.position.maxScrollExtent;
    if (max <= 0) return;
    final delta = widget.speed / 60.0;
    var next = _scrollController.offset + delta;
    if (next >= max) next -= max;
    _scrollController.jumpTo(next);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String get _joined => widget.items.join('   ●   ');

  @override
  Widget build(BuildContext context) {
    final text = '  $_joined   ●   $_joined   ●   $_joined   ●   $_joined   ●   ';
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(painter: _HazardStripePainter()),
          ListView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(4, (i) {
              return Center(
                child: Text(
                  text,
                  style: AppTextStyles.eyebrow(
                    color: AppColors.onCaution,
                    size: 12.5,
                  ).copyWith(letterSpacing: 2.4, fontWeight: FontWeight.w700),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

/// Paints repeating diagonal yellow/near-black stripes, like hazard tape.
class _HazardStripePainter extends CustomPainter {
  static const double _stripeWidth = 34;

  @override
  void paint(Canvas canvas, Size size) {
    final basePaint = Paint()..color = AppColors.caution;
    canvas.drawRect(Offset.zero & size, basePaint);

    final stripePaint = Paint()..color = AppColors.concreteDeep.withOpacity(0.92);
    canvas.save();
    canvas.clipRect(Offset.zero & size);

    final count = ((size.width + size.height) / _stripeWidth).ceil() + 2;
    for (var i = -1; i < count; i++) {
      final x = i * _stripeWidth * 2 - size.height;
      final path = Path()
        ..moveTo(x, size.height)
        ..lineTo(x + size.height, 0)
        ..lineTo(x + size.height + _stripeWidth, 0)
        ..lineTo(x + _stripeWidth, size.height)
        ..close();
      canvas.drawPath(path, stripePaint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
