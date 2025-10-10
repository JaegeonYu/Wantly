import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/text_styles.dart';
import '../../../data/models/wishlist_item.dart';
import '../../../data/models/category.dart';
import '../../../data/repositories/category_repository_impl.dart';
import '../../providers/wishlist_provider.dart';

/// 위시리스트 아이템 추가/수정 화면
class AddEditWishlistScreen extends StatefulWidget {
  final WishlistItem? item; // null이면 추가 모드, 값이 있으면 수정 모드

  const AddEditWishlistScreen({super.key, this.item});

  @override
  State<AddEditWishlistScreen> createState() => _AddEditWishlistScreenState();
}

class _AddEditWishlistScreenState extends State<AddEditWishlistScreen> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = const Uuid();
  final _categoryRepository = CategoryRepositoryImpl();
  final _imagePicker = ImagePicker();

  // 폼 컨트롤러
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _reasonController;
  late TextEditingController _urlController;

  // 상태 변수
  List<Category> _categories = [];
  Category? _selectedCategory;
  String? _imageUrl;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _loadCategories();
  }

  /// 컨트롤러 초기화
  void _initializeControllers() {
    final item = widget.item;
    _nameController = TextEditingController(text: item?.name ?? '');
    _priceController = TextEditingController(
      text: item?.price != null ? item!.price.toString() : '',
    );
    _reasonController = TextEditingController(text: item?.reason ?? '');
    _urlController = TextEditingController(text: item?.memo ?? '');
    _imageUrl = item?.imageUrl;
  }

  /// 카테고리 목록 불러오기
  Future<void> _loadCategories() async {
    final categories = await _categoryRepository.getAllCategories();
    setState(() {
      _categories = categories;
      if (widget.item != null) {
        // 수정 모드: 기존 카테고리 선택
        _selectedCategory = categories.firstWhere(
          (c) => c.id == widget.item!.categoryId,
          orElse: () => categories.first,
        );
      } else if (categories.isNotEmpty) {
        // 추가 모드: 첫 번째 카테고리 기본 선택
        _selectedCategory = categories.first;
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _reasonController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  /// 이미지 선택 옵션 표시
  Future<void> _pickImage() async {
    // 갤러리와 카메라 중 선택
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppSizes.paddingLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('이미지 선택', style: AppTextStyles.h3),
            const SizedBox(height: AppSizes.spaceMd),
            ListTile(
              leading: const Icon(
                Icons.photo_library,
                color: AppColors.primary,
              ),
              title: const Text('갤러리에서 선택'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: AppColors.primary),
              title: const Text('카메라로 촬영'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            const SizedBox(height: AppSizes.spaceSm),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('취소'),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    await _selectImage(source);
  }

  /// 이미지 선택 처리
  Future<void> _selectImage(ImageSource source) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (image != null) {
        setState(() {
          _imageUrl = image.path;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('이미지가 선택되었습니다'),
              duration: Duration(seconds: 1),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('이미지를 선택할 수 없습니다: ${e.toString()}')),
        );
      }
    }
  }

  /// 저장 처리
  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedCategory == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('카테고리를 선택해주세요')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final provider = context.read<WishlistProvider>();

      // 아이템 생성
      final item = WishlistItem(
        id: widget.item?.id ?? _uuid.v4(),
        name: _nameController.text.trim(),
        categoryId: _selectedCategory!.id,
        price: int.parse(_priceController.text.trim()),
        reason: _reasonController.text.trim(),
        imageUrl: _imageUrl,
        memo: _urlController.text.trim(),
        createdAt: widget.item?.createdAt ?? DateTime.now(),
        priority: widget.item?.priority ?? 0,
      );

      bool success;
      if (widget.item == null) {
        // 추가 모드
        success = await provider.addItem(item);
      } else {
        // 수정 모드
        success = await provider.updateItem(item);
      }

      setState(() => _isLoading = false);

      if (success && mounted) {
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.item == null ? '아이템이 추가되었습니다' : '아이템이 수정되었습니다',
            ),
          ),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('저장 실패: ${e.toString()}')));
      }
    }
  }

  /// 카테고리 선택 바텀시트
  Future<void> _showCategoryPicker() async {
    final selected = await showModalBottomSheet<Category>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppSizes.paddingLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('카테고리 선택', style: AppTextStyles.h3),
            const SizedBox(height: AppSizes.spaceMd),
            Wrap(
              spacing: AppSizes.spaceSm,
              runSpacing: AppSizes.spaceSm,
              children: _categories.map((category) {
                final isSelected = category.id == _selectedCategory?.id;
                return ChoiceChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        category.icon,
                        size: AppSizes.iconSm,
                        color: isSelected ? Colors.white : category.color,
                      ),
                      const SizedBox(width: AppSizes.spaceXs),
                      Text(category.name),
                    ],
                  ),
                  selected: isSelected,
                  onSelected: (_) {
                    Navigator.pop(context, category);
                  },
                  selectedColor: category.color,
                  backgroundColor: category.color.withOpacity(0.1),
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : category.color,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );

    if (selected != null) {
      setState(() {
        _selectedCategory = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.item != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? '아이템 수정' : AppStrings.addItem),
        actions: [
          if (_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(AppSizes.paddingMd),
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          else
            TextButton(
              onPressed: _handleSave,
              child: Text(
                '저장',
                style: AppTextStyles.button.copyWith(color: AppColors.primary),
              ),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSizes.paddingLg),
          children: [
            // 이미지 추가
            _buildImageSection(),
            const SizedBox(height: AppSizes.spaceLg),

            // 물품명
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '물품명',
                hintText: '갖고 싶은 물건을 입력하세요',
                prefixIcon: Icon(Icons.shopping_bag),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '물품명을 입력해주세요';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: AppSizes.spaceMd),

            // 예상 가격
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: '예상 가격',
                hintText: '0',
                prefixIcon: Icon(Icons.attach_money),
                suffixText: '원',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '예상 가격을 입력해주세요';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: AppSizes.spaceMd),

            // 카테고리 선택
            InkWell(
              onTap: _showCategoryPicker,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: '카테고리',
                  prefixIcon: Icon(Icons.category),
                  suffixIcon: Icon(Icons.arrow_drop_down),
                ),
                child: _selectedCategory != null
                    ? Row(
                        children: [
                          Icon(
                            _selectedCategory!.icon,
                            size: AppSizes.iconSm,
                            color: _selectedCategory!.color,
                          ),
                          const SizedBox(width: AppSizes.spaceXs),
                          Text(_selectedCategory!.name),
                        ],
                      )
                    : const Text('카테고리를 선택하세요'),
              ),
            ),
            const SizedBox(height: AppSizes.spaceMd),

            // 사고 싶은 이유
            TextFormField(
              controller: _reasonController,
              decoration: const InputDecoration(
                labelText: '사고 싶은 이유',
                hintText: '왜 이 물건을 갖고 싶은가요?',
                prefixIcon: Icon(Icons.edit_note),
                alignLabelWithHint: true,
              ),
              maxLines: 4,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '사고 싶은 이유를 입력해주세요';
                }
                return null;
              },
              textInputAction: TextInputAction.newline,
            ),
            const SizedBox(height: AppSizes.spaceMd),

            // 추가 메모 (선택사항)
            TextFormField(
              controller: _urlController,
              decoration: const InputDecoration(
                labelText: '추가 메모 (선택사항)',
                hintText: '추가 정보를 입력하세요',
                prefixIcon: Icon(Icons.note),
              ),
              maxLines: 2,
              textInputAction: TextInputAction.done,
            ),
          ],
        ),
      ),
    );
  }

  /// 이미지 섹션 빌드
  Widget _buildImageSection() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: AppColors.grey100,
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          border: Border.all(color: AppColors.grey300),
        ),
        child: _imageUrl != null
            ? Stack(
                children: [
                  // 이미지 표시
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                    child: _buildImage(_imageUrl!),
                  ),
                  // 변경 버튼
                  Positioned(
                    right: 8,
                    top: 8,
                    child: CircleAvatar(
                      backgroundColor: Colors.black54,
                      child: IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: _pickImage,
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate,
                    size: 48,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(height: AppSizes.spaceSm),
                  Text(
                    '이미지 추가 (선택사항)',
                    style: AppTextStyles.body2.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  /// 이미지 빌드 (로컬 파일 또는 네트워크 URL 처리)
  Widget _buildImage(String imagePath) {
    // URL인지 로컬 파일인지 확인
    final isUrl =
        imagePath.startsWith('http://') || imagePath.startsWith('https://');

    if (isUrl) {
      // 네트워크 이미지
      return Image.network(
        imagePath,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Center(child: Icon(Icons.broken_image, size: 48));
        },
      );
    } else {
      // 로컬 파일 이미지
      if (kIsWeb) {
        // 웹 환경에서는 네트워크 이미지로 처리
        return Image.network(
          imagePath,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Center(child: Icon(Icons.broken_image, size: 48));
          },
        );
      } else {
        // 모바일 환경에서는 파일 이미지로 처리
        return Image.file(
          File(imagePath),
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Center(child: Icon(Icons.broken_image, size: 48));
          },
        );
      }
    }
  }
}
