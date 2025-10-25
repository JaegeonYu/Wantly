import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/text_styles.dart';
import '../../../data/models/owned_item.dart';
import '../../../data/models/category.dart';
import '../../../data/repositories/category_repository_impl.dart';
import '../../providers/owned_provider.dart';

/// 구매 아이템 상세 화면
class OwnedDetailScreen extends StatefulWidget {
  final OwnedItem item;

  const OwnedDetailScreen({super.key, required this.item});

  @override
  State<OwnedDetailScreen> createState() => _OwnedDetailScreenState();
}

class _OwnedDetailScreenState extends State<OwnedDetailScreen> {
  final _categoryRepository = CategoryRepositoryImpl();
  String? _categoryName;
  IconData? _categoryIcon;
  Color? _categoryColor;

  @override
  void initState() {
    super.initState();
    _loadCategoryInfo();
  }

  /// 카테고리 정보 로드
  Future<void> _loadCategoryInfo() async {
    final categories = await _categoryRepository.getAllCategories();
    final category = categories.firstWhere(
      (c) => c.id == widget.item.categoryId,
      orElse: () => categories.first,
    );

    setState(() {
      _categoryName = category.name;
      _categoryIcon = category.icon;
      _categoryColor = category.color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('구매 상세'),
        actions: [
          // 삭제 버튼
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _handleDelete,
            tooltip: '삭제',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 이미지 섹션
            _buildImageSection(),

            // 기본 정보 섹션
            _buildBasicInfoSection(),

            // 가격 비교 섹션
            _buildPriceComparisonSection(),

            // 만족도 섹션
            _buildSatisfactionSection(),

            // 메타 정보 섹션
            _buildMetaInfoSection(),

            const SizedBox(height: AppSizes.spaceXl),
          ],
        ),
      ),
    );
  }

  /// 이미지 섹션
  Widget _buildImageSection() {
    if (!widget.item.hasImage) {
      return Container(
        height: 250,
        color: AppColors.grey100,
        child: const Center(
          child: Icon(
            Icons.shopping_bag_outlined,
            size: 80,
            color: AppColors.grey400,
          ),
        ),
      );
    }

    return Container(
      height: 300,
      color: AppColors.grey100,
      child: _buildImage(widget.item.imageUrl!),
    );
  }

  /// 이미지 빌드
  Widget _buildImage(String imagePath) {
    final isUrl =
        imagePath.startsWith('http://') || imagePath.startsWith('https://');

    if (isUrl) {
      return Image.network(
        imagePath,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(Icons.broken_image, size: 80, color: AppColors.grey400),
          );
        },
      );
    } else {
      if (kIsWeb) {
        return Image.network(
          imagePath,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(
                Icons.broken_image,
                size: 80,
                color: AppColors.grey400,
              ),
            );
          },
        );
      } else {
        return Image.file(
          File(imagePath),
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(
                Icons.broken_image,
                size: 80,
                color: AppColors.grey400,
              ),
            );
          },
        );
      }
    }
  }

  /// 기본 정보 섹션
  Widget _buildBasicInfoSection() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingLg),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 물품명
          Text(widget.item.name, style: AppTextStyles.h2),
          const SizedBox(height: AppSizes.spaceMd),

          // 카테고리
          if (_categoryName != null)
            Row(
              children: [
                Icon(
                  _categoryIcon ?? Icons.category,
                  size: AppSizes.iconSm,
                  color: _categoryColor ?? AppColors.grey600,
                ),
                const SizedBox(width: AppSizes.spaceXs),
                Text(
                  _categoryName!,
                  style: AppTextStyles.body1.copyWith(
                    color: _categoryColor ?? AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  /// 가격 비교 섹션
  Widget _buildPriceComparisonSection() {
    return Container(
      margin: const EdgeInsets.only(top: AppSizes.spaceSm),
      padding: const EdgeInsets.all(AppSizes.paddingLg),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('가격 비교', style: AppTextStyles.h4),
          const SizedBox(height: AppSizes.spaceMd),

          // 실제 구매 가격
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '실제 가격',
                style: AppTextStyles.body1.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                widget.item.formattedActualPrice,
                style: AppTextStyles.priceLarge,
              ),
            ],
          ),

          // 예상 가격 (있을 경우)
          if (widget.item.expectedPrice != null) ...[
            const SizedBox(height: AppSizes.spaceSm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '예상 가격',
                  style: AppTextStyles.body1.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  widget.item.formattedEstimatedPrice,
                  style: AppTextStyles.body1.copyWith(
                    decoration: TextDecoration.lineThrough,
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spaceMd),

            // 가격 차이 표시
            Container(
              padding: const EdgeInsets.all(AppSizes.paddingMd),
              decoration: BoxDecoration(
                color: widget.item.wasCheaper
                    ? AppColors.success.withOpacity(0.1)
                    : AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.item.wasCheaper
                        ? Icons.trending_down
                        : Icons.trending_up,
                    color: widget.item.wasCheaper
                        ? AppColors.success
                        : AppColors.error,
                    size: 24,
                  ),
                  const SizedBox(width: AppSizes.spaceXs),
                  Text(
                    widget.item.wasCheaper ? '절약' : '초과',
                    style: AppTextStyles.bodyBold.copyWith(
                      color: widget.item.wasCheaper
                          ? AppColors.success
                          : AppColors.error,
                    ),
                  ),
                  const SizedBox(width: AppSizes.spaceXs),
                  Text(
                    widget.item.formattedPriceDifference,
                    style: AppTextStyles.h3.copyWith(
                      color: widget.item.wasCheaper
                          ? AppColors.success
                          : AppColors.error,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// 만족도 섹션
  Widget _buildSatisfactionSection() {
    return Container(
      margin: const EdgeInsets.only(top: AppSizes.spaceSm),
      padding: const EdgeInsets.all(AppSizes.paddingLg),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('만족도', style: AppTextStyles.h4),
          const SizedBox(height: AppSizes.spaceMd),

          // 별점 표시
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(5, (index) {
                return Icon(
                  index < widget.item.satisfactionScore.round()
                      ? Icons.star
                      : Icons.star_border,
                  color: AppColors.starColor,
                  size: 36,
                );
              }),
              const SizedBox(width: AppSizes.spaceSm),
              Text(
                widget.item.satisfactionScore.toStringAsFixed(1),
                style: AppTextStyles.h2.copyWith(color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceLg),

          // 구매 후기
          if (widget.item.review.isNotEmpty) ...[
            Row(
              children: [
                const Icon(
                  Icons.rate_review,
                  size: AppSizes.iconSm,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppSizes.spaceXs),
                Text('구매 후기', style: AppTextStyles.h4),
              ],
            ),
            const SizedBox(height: AppSizes.spaceSm),
            Text(widget.item.review, style: AppTextStyles.body1),
            const SizedBox(height: AppSizes.spaceMd),
          ],

          // 다시 사고 싶은지 여부
          if (widget.item.wouldBuyAgain)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.paddingMd,
                vertical: AppSizes.paddingSm,
              ),
              decoration: BoxDecoration(
                color: AppColors.info.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppSizes.radiusSm),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.repeat,
                    size: AppSizes.iconSm,
                    color: AppColors.info,
                  ),
                  const SizedBox(width: AppSizes.spaceXs),
                  Text(
                    '다시 사고 싶어요',
                    style: AppTextStyles.body2.copyWith(
                      color: AppColors.info,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

          // 태그
          if (widget.item.tags.isNotEmpty) ...[
            const SizedBox(height: AppSizes.spaceMd),
            Row(
              children: [
                const Icon(
                  Icons.local_offer,
                  size: AppSizes.iconSm,
                  color: AppColors.info,
                ),
                const SizedBox(width: AppSizes.spaceXs),
                Text('태그', style: AppTextStyles.h4),
              ],
            ),
            const SizedBox(height: AppSizes.spaceSm),
            Wrap(
              spacing: AppSizes.spaceXs,
              runSpacing: AppSizes.spaceXs,
              children: widget.item.tags.map((tag) {
                return Chip(
                  label: Text(tag),
                  backgroundColor: AppColors.grey100,
                  labelStyle: AppTextStyles.caption,
                  visualDensity: VisualDensity.compact,
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  /// 메타 정보 섹션
  Widget _buildMetaInfoSection() {
    return Container(
      margin: const EdgeInsets.only(top: AppSizes.spaceSm),
      padding: const EdgeInsets.all(AppSizes.paddingLg),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('구매 정보', style: AppTextStyles.h4),
          const SizedBox(height: AppSizes.spaceMd),

          // 구매 날짜
          _buildInfoRow(
            Icons.shopping_cart,
            '구매 날짜',
            _formatDate(widget.item.purchaseDate),
          ),
          const SizedBox(height: AppSizes.spaceSm),

          // 구매 후 경과 일수
          _buildInfoRow(
            Icons.timelapse,
            '구매 후',
            '${widget.item.purchasedDaysAgo}일',
          ),

          // 위시리스트 대기 기간 (있을 경우)
          if (widget.item.daysInWishlist != null) ...[
            const SizedBox(height: AppSizes.spaceSm),
            _buildInfoRow(
              Icons.favorite,
              '고민 기간',
              '${widget.item.daysInWishlist}일',
            ),
          ],

          // 위시리스트 등록일 (있을 경우)
          if (widget.item.createdAt != null) ...[
            const SizedBox(height: AppSizes.spaceSm),
            _buildInfoRow(
              Icons.calendar_today,
              '등록 날짜',
              _formatDate(widget.item.createdAt!),
            ),
          ],

          // 메모 (있을 경우)
          if (widget.item.memo.isNotEmpty) ...[
            const SizedBox(height: AppSizes.spaceLg),
            Row(
              children: [
                const Icon(
                  Icons.note,
                  size: AppSizes.iconSm,
                  color: AppColors.grey600,
                ),
                const SizedBox(width: AppSizes.spaceXs),
                Text('메모', style: AppTextStyles.h4),
              ],
            ),
            const SizedBox(height: AppSizes.spaceSm),
            Text(widget.item.memo, style: AppTextStyles.body1),
          ],
        ],
      ),
    );
  }

  /// 정보 행 위젯
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: AppSizes.iconSm, color: AppColors.grey600),
        const SizedBox(width: AppSizes.spaceXs),
        Text(
          '$label: ',
          style: AppTextStyles.body2.copyWith(color: AppColors.textSecondary),
        ),
        Text(
          value,
          style: AppTextStyles.body2.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  /// 날짜 포맷팅
  String _formatDate(DateTime date) {
    return '${date.year}년 ${date.month}월 ${date.day}일';
  }

  /// 삭제 처리
  Future<void> _handleDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('삭제 확인'),
        content: Text('${widget.item.name}을(를) 삭제하시겠어요?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('삭제'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final success = await context.read<OwnedProvider>().deleteItem(
        widget.item.id,
      );

      if (success && mounted) {
        Navigator.pop(context); // 상세 화면 닫기
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('삭제되었습니다')));
      }
    }
  }
}
