import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/text_styles.dart';

/// 빈 구매 목록 위젯
class EmptyOwnedWidget extends StatelessWidget {
  const EmptyOwnedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingLg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 아이콘
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.grey100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 60,
                color: AppColors.grey400,
              ),
            ),
            const SizedBox(height: AppSizes.spaceLg),

            // 제목
            Text(
              '아직 구매한 물건이 없어요',
              style: AppTextStyles.h3,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.spaceSm),

            // 설명
            Text(
              '위시리스트에서 물건을 구매 완료하면\n여기에 표시됩니다',
              style: AppTextStyles.body1.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.spaceLg),

            // 힌트 카드
            Container(
              padding: const EdgeInsets.all(AppSizes.paddingMd),
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                border: Border.all(
                  color: AppColors.primaryLight.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: AppSizes.spaceXs),
                  Flexible(
                    child: Text(
                      '위시리스트에서 좌로 스와이프하여\n구매 완료 처리할 수 있어요',
                      style: AppTextStyles.body2.copyWith(
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
