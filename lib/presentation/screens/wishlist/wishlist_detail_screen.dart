import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/text_styles.dart';
import '../../../data/models/wishlist_item.dart';
import '../../../data/models/category.dart';
import '../../../data/repositories/category_repository_impl.dart';
import '../../providers/wishlist_provider.dart';
import 'add_edit_wishlist_screen.dart';

/// 위시리스트 아이템 상세 화면
class WishlistDetailScreen extends StatefulWidget {
  final WishlistItem item;

  const WishlistDetailScreen({super.key, required this.item});

  @override
  State<WishlistDetailScreen> createState() => _WishlistDetailScreenState();
}

class _WishlistDetailScreenState extends State<WishlistDetailScreen> {
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
        title: const Text('아이템 상세'),
        actions: [
          // 편집 버튼
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _handleEdit,
            tooltip: '편집',
          ),
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

            // 상세 내용 섹션
            _buildDetailSection(),

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

          // 가격
          Text(widget.item.formattedPrice, style: AppTextStyles.priceLarge),
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

  /// 상세 내용 섹션
  Widget _buildDetailSection() {
    return Container(
      margin: const EdgeInsets.only(top: AppSizes.spaceSm),
      padding: const EdgeInsets.all(AppSizes.paddingLg),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 사고 싶은 이유
          if (widget.item.reason.isNotEmpty) ...[
            Row(
              children: [
                const Icon(
                  Icons.favorite,
                  size: AppSizes.iconSm,
                  color: AppColors.secondary,
                ),
                const SizedBox(width: AppSizes.spaceXs),
                Text('사고 싶은 이유', style: AppTextStyles.h4),
              ],
            ),
            const SizedBox(height: AppSizes.spaceSm),
            Text(widget.item.reason, style: AppTextStyles.body1),
            const SizedBox(height: AppSizes.spaceLg),
          ],

          // 추가 메모
          if (widget.item.memo.isNotEmpty) ...[
            Row(
              children: [
                const Icon(
                  Icons.note,
                  size: AppSizes.iconSm,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppSizes.spaceXs),
                Text('추가 메모', style: AppTextStyles.h4),
              ],
            ),
            const SizedBox(height: AppSizes.spaceSm),
            Text(widget.item.memo, style: AppTextStyles.body1),
            const SizedBox(height: AppSizes.spaceLg),
          ],

          // 태그
          if (widget.item.tags.isNotEmpty) ...[
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
          Text('등록 정보', style: AppTextStyles.h4),
          const SizedBox(height: AppSizes.spaceMd),

          // 등록 날짜
          _buildInfoRow(
            Icons.calendar_today,
            '등록 날짜',
            _formatDate(widget.item.createdAt),
          ),
          const SizedBox(height: AppSizes.spaceSm),

          // 경과 일수
          _buildInfoRow(Icons.timelapse, '경과 일수', '${widget.item.daysAgo}일'),

          // 수정 날짜 (있을 경우)
          if (widget.item.updatedAt != null) ...[
            const SizedBox(height: AppSizes.spaceSm),
            _buildInfoRow(
              Icons.update,
              '최종 수정',
              _formatDate(widget.item.updatedAt!),
            ),
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

  /// 편집 처리
  Future<void> _handleEdit() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditWishlistScreen(item: widget.item),
      ),
    );

    // 수정 후 화면 갱신
    if (result == true && mounted) {
      await context.read<WishlistProvider>().loadItems();
      // 현재 화면도 닫고 목록으로 돌아가기
      if (mounted) {
        Navigator.pop(context);
      }
    }
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
      final success = await context.read<WishlistProvider>().deleteItem(
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
