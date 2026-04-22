import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateActivity extends StatefulWidget {
  const CreateActivity({super.key});

  @override
  State<CreateActivity> createState() => _CreateActivityState();
}

class _CreateActivityState extends State<CreateActivity> {
  // ——— бэкэнд: контроллеры и стейт ———
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  String _selectedCategory = 'Тусовка';
  int _peopleCount = 4;
  bool _isLoading = false;

  // дата/время активности
  DateTime _selectedDateTime =
      DateTime.now().add(const Duration(hours: 2));

  // ——— UI-мета для категорий ———
  static const Map<String, _CategoryMeta> _categoryMeta = {
    'Тусовка': _CategoryMeta(
      emoji: '🎉',
      icon: Icons.local_bar,
      gradientStart: Color(0xFF4A1A3E),
      gradientEnd: Color(0xFF1A0A2E),
      accent: Color(0xFFD4537E),
    ),
    'Спорт': _CategoryMeta(
      emoji: '⚽',
      icon: Icons.sports_soccer,
      gradientStart: Color(0xFF1A3A6E),
      gradientEnd: Color(0xFF0A1A3E),
      accent: Color(0xFF378ADD),
    ),
    'Еда': _CategoryMeta(
      emoji: '🍔',
      icon: Icons.restaurant,
      gradientStart: Color(0xFF4A2E1A),
      gradientEnd: Color(0xFF2A1508),
      accent: Color(0xFFEF9F27),
    ),
    'Кино': _CategoryMeta(
      emoji: '🎬',
      icon: Icons.movie,
      gradientStart: Color(0xFF2E1A4A),
      gradientEnd: Color(0xFF0F0A2E),
      accent: Color(0xFF7F77DD),
    ),
  };

  _CategoryMeta get _currentMeta =>
      _categoryMeta[_selectedCategory] ?? _categoryMeta['Тусовка']!;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  // ——— выбор даты и времени ———
  Future<void> _pickDateTime() async {
    final now = DateTime.now();

    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime.isBefore(now) ? now : _selectedDateTime,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: _accent,
              onPrimary: Colors.white,
              surface: _card,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: _bg,
          ),
          child: child!,
        );
      },
    );

    if (date == null) return;
    if (!mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: _accent,
              onPrimary: Colors.white,
              surface: _card,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: _bg,
          ),
          child: MediaQuery(
            data:
                MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          ),
        );
      },
    );

    if (time == null) return;

    setState(() {
      _selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  // форматирование даты/времени для отображения
  String _formatDateTime(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(dt.year, dt.month, dt.day);
    final diff = target.difference(today).inDays;

    final hh = dt.hour.toString().padLeft(2, '0');
    final mm = dt.minute.toString().padLeft(2, '0');
    final time = '$hh:$mm';

    if (diff == 0) return 'Сегодня, $time';
    if (diff == 1) return 'Завтра, $time';
    if (diff == 2) return 'Послезавтра, $time';

    const months = [
      'янв', 'фев', 'мар', 'апр', 'мая', 'июн',
      'июл', 'авг', 'сен', 'окт', 'ноя', 'дек',
    ];
    return '${dt.day} ${months[dt.month - 1]}, $time';
  }

  // ——— бэкэнд: publish ———
  Future<void> _publish() async {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Введите название активности"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // проверка — дата не в прошлом
    if (_selectedDateTime.isBefore(DateTime.now())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Выберите время в будущем"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final supabase = Supabase.instance.client;
      final userId = supabase.auth.currentUser?.id;

      await supabase.from('activities').insert({
        'creator_id': userId,
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'category': _selectedCategory,
        'location': _locationController.text.trim(),
        'max_people': _peopleCount,
        'scheduled_at': _selectedDateTime.toUtc().toIso8601String(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Активность опубликована!"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Ошибка: $e"), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // ——— UI константы ———
  static const _bg = Color(0xFF131221);
  static const _bgDeep = Color(0xFF0E0D1A);
  static const _card = Color(0xFF1C1B2A);
  static const _cardSoft = Color(0xFF23222F);
  static const _accent = Color(0xFFE93C35);
  static const _textMuted = Color(0xFF8B8A99);
  static const _textLabel = Color(0xFF6A6979);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Новая активность',
          style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: _bgDeep,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCoverPreview(),
              const SizedBox(height: 20),
              _buildTitleField(),
              const SizedBox(height: 24),
              _buildSectionLabel('КАТЕГОРИЯ'),
              const SizedBox(height: 10),
              _buildCategoryChips(),
              const SizedBox(height: 24),
              _buildDetailsCard(),
              const SizedBox(height: 24),
              _buildSectionLabel('СКОЛЬКО ЧЕЛОВЕК'),
              const SizedBox(height: 10),
              _buildPeopleCounter(),
              const SizedBox(height: 32),
              _buildPublishButton(),
            ],
          ),
        ),
      ),
    );
  }

  // ——— авто-обложка ———
  Widget _buildCoverPreview() {
    final meta = _currentMeta;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [meta.gradientStart, meta.gradientEnd],
        ),
        boxShadow: [
          BoxShadow(
            color: meta.gradientStart.withOpacity(0.3),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 20,
            top: 0,
            bottom: 0,
            child: Center(
              child: Text(
                meta.emoji,
                style: const TextStyle(fontSize: 56),
              ),
            ),
          ),
          Positioned(
            left: 14,
            bottom: 12,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.35),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.auto_awesome,
                      color: Colors.white70, size: 11),
                  const SizedBox(width: 5),
                  Text(
                    'Обложка: ${_selectedCategory.toLowerCase()}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 14,
            top: 14,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1D9E75),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'Превью',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ——— поле заголовка ———
  Widget _buildTitleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Что делаем?',
          style: TextStyle(
              color: _textMuted,
              fontSize: 13,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: _titleController,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
          cursorColor: _accent,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            hintText: 'Поход в кино',
            hintStyle: TextStyle(
              color: Color(0xFF3C3B4A),
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            isDense: true,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: _textLabel,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
    );
  }

  // ——— чипсы категорий ———
  Widget _buildCategoryChips() {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _categoryMeta.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final name = _categoryMeta.keys.elementAt(index);
          return _buildCategoryChip(name);
        },
      ),
    );
  }

  Widget _buildCategoryChip(String name) {
    final meta = _categoryMeta[name]!;
    final isSelected = _selectedCategory == name;
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = name),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? meta.accent.withOpacity(0.15) : _card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color:
                isSelected ? meta.accent : Colors.white.withOpacity(0.04),
            width: isSelected ? 1 : 0.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(meta.emoji, style: const TextStyle(fontSize: 15)),
            const SizedBox(width: 7),
            Text(
              name,
              style: TextStyle(
                color: isSelected ? Colors.white : _textMuted,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ——— карточка деталей ———
  Widget _buildDetailsCard() {
    return Container(
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.04)),
      ),
      child: Column(
        children: [
          // описание
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.notes_rounded,
                    color: Colors.white.withOpacity(0.35), size: 18),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _descriptionController,
                    maxLines: 3,
                    minLines: 1,
                    cursorColor: _accent,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 14, height: 1.4),
                    decoration: InputDecoration(
                      hintText: 'Опиши, что планируешь (не обязательно)',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.25),
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _divider(),
          // когда
          _buildDetailRow(
            icon: Icons.schedule_rounded,
            iconBg: _accent.withOpacity(0.15),
            iconColor: _accent,
            label: 'КОГДА',
            valueWidget: Text(
              _formatDateTime(_selectedDateTime),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: _pickDateTime,
          ),
          _divider(),
          // где
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7F77DD).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Icon(Icons.location_on_rounded,
                      color: Color(0xFF7F77DD), size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ГДЕ',
                        style: TextStyle(
                            color: _textLabel,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8),
                      ),
                      const SizedBox(height: 2),
                      TextField(
                        controller: _locationController,
                        cursorColor: _accent,
                        keyboardType: TextInputType.streetAddress,
                        textCapitalization: TextCapitalization.sentences,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          hintText: 'Кафе, парк, адрес...',
                          hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.25),
                              fontSize: 15),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() => Container(
        height: 0.5,
        color: Colors.white.withOpacity(0.05),
        margin: const EdgeInsets.symmetric(horizontal: 14),
      );

  Widget _buildDetailRow({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String label,
    required Widget valueWidget,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: _textLabel,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 2),
                  valueWidget,
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded,
                color: Colors.white.withOpacity(0.25), size: 20),
          ],
        ),
      ),
    );
  }

  // ——— счётчик людей ———
  Widget _buildPeopleCounter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.04)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1D9E75).withOpacity(0.15),
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Icon(Icons.group_rounded,
                color: Color(0xFF1D9E75), size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '$_peopleCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _peopleWord(_peopleCount),
                      style: const TextStyle(
                          color: _textMuted, fontSize: 14),
                    ),
                  ],
                ),
                const Text(
                  'максимум 10',
                  style: TextStyle(color: _textLabel, fontSize: 11),
                ),
              ],
            ),
          ),
          _counterButton(
            icon: Icons.remove_rounded,
            enabled: _peopleCount > 2,
            onTap: () {
              if (_peopleCount > 2) setState(() => _peopleCount--);
            },
          ),
          const SizedBox(width: 8),
          _counterButton(
            icon: Icons.add_rounded,
            enabled: _peopleCount < 10,
            onTap: () {
              if (_peopleCount < 10) setState(() => _peopleCount++);
            },
            primary: true,
          ),
        ],
      ),
    );
  }

  Widget _counterButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool enabled,
    bool primary = false,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: primary
              ? (enabled ? _accent : _accent.withOpacity(0.3))
              : (enabled ? _cardSoft : _cardSoft.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(10),
          border: primary
              ? null
              : Border.all(color: Colors.white.withOpacity(0.06)),
        ),
        child: Icon(
          icon,
          color: enabled ? Colors.white : Colors.white.withOpacity(0.3),
          size: 18,
        ),
      ),
    );
  }

  String _peopleWord(int n) {
    if (n % 10 == 1 && n % 100 != 11) return 'человек';
    if ([2, 3, 4].contains(n % 10) &&
        ![12, 13, 14].contains(n % 100)) return 'человека';
    return 'человек';
  }

  // ——— кнопка публикации ———
  Widget _buildPublishButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: Material(
        color: _accent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: _isLoading ? null : _publish,
          borderRadius: BorderRadius.circular(14),
          child: Center(
            child: _isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2.5),
                  )
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Опубликовать",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded,
                          color: Colors.white, size: 18),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

// ——— мета категории ———
class _CategoryMeta {
  final String emoji;
  final IconData icon;
  final Color gradientStart;
  final Color gradientEnd;
  final Color accent;

  const _CategoryMeta({
    required this.emoji,
    required this.icon,
    required this.gradientStart,
    required this.gradientEnd,
    required this.accent,
  });
}