import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/reveal_on_scroll.dart';

class StatsStrip extends StatelessWidget {
  const StatsStrip({super.key});

  static const _stats = [
    ('850+', 'ACTIVE MEMBERS'),
    ('12', 'COACHES ON FLOOR'),
    ('3', 'COACHED PROGRAMS'),
    ('6', 'YEARS ON PEPONI ROAD'),
  ];

  @override
  Widget build(BuildContext context) {
    final useCompactLayout = !Responsive.isDesktop(context);
    return RevealOnScroll(
      child: Container(
        color: AppColors.surface,
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.gutter(context),
          vertical: useCompactLayout ? 28 : 40,
        ),
        child: useCompactLayout
            ? Wrap(
                spacing: 24,
                runSpacing: 24,
                children: _stats.map((s) => _Stat(value: s.$1, label: s.$2)).toList(),
              )
            : IntrinsicHeight(
                child: Row(
                  children: [
                    for (var i = 0; i < _stats.length; i++) ...[
                      if (i != 0)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: VerticalDivider(color: AppColors.hairline, width: 1),
                        ),
                      _Stat(value: _stats[i].$1, label: _stats[i].$2),
                    ],
                  ],
                ),
              ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value, style: AppTextStyles.data(color: AppColors.caution, size: 40)),
        const SizedBox(height: 6),
        Text(label, style: AppTextStyles.dataSmall()),
      ],
    );
  }
}
