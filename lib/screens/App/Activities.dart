import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Create_Activity.dart';
import 'Profile.dart';
import 'Chat.dart';
import 'Search.dart';

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  // ——— UI константы (синхронизированы с CreateActivity) ———
  static const _bg = Color(0xFF131221);
  static const _bgDeep = Color(0xFF0E0D1A);
  static const _card = Color(0xFF1C1B2A);
  static const _cardSoft = Color(0xFF23222F);
  static const _accent = Color(0xFFE93C35);
  static const _textMuted = Color(0xFF8B8A99);
  static const _textLabel = Color(0xFF6A6979);
  static const _social = Color(0xFF7F77DD);
  static const _success = Color(0xFF1D9E75);

  // ——— UI-мета категорий (та же что в CreateActivity + "Все") ———
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

  // ——— состояние ———
  bool _isMapView = false;
  String _selectedFilter = 'Все';
  bool _isLoading = true;
  List<_ActivityData> _activities = [];
  String? _error;

  final List<String> _filters = ['Все', 'Тусовка', 'Спорт', 'Еда', 'Кино'];

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  // ——— загрузка из Supabase ———
  Future<void> _loadActivities() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final supabase = Supabase.instance.client;
      final rows = await supabase
          .from('activities')
          .select()
          .order('scheduled_at', ascending: true);

      final list = (rows as List)
          .map((r) => _ActivityData.fromMap(r as Map<String, dynamic>))
          .toList();

      if (mounted) {
        setState(() {
          _activities = list;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  // ——— фильтрация ———
List<_ActivityData> get _filteredActivities {
  final notFull = _activities.where((a) => a.currentPeople < a.maxPeople);
  if (_selectedFilter == 'Все') return notFull.toList();
  return notFull.where((a) => a.category == _selectedFilter).toList();
}

  _CategoryMeta _metaFor(String? category) {
    return _categoryMeta[category] ?? _categoryMeta['Тусовка']!;
  }

  // ——— форматирование ———
  String _formatWhen(DateTime? dt) {
    if (dt == null) return 'Время не указано';
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(dt.year, dt.month, dt.day);
    final diff = target.difference(today).inDays;

    final hh = dt.hour.toString().padLeft(2, '0');
    final mm = dt.minute.toString().padLeft(2, '0');
    final time = '$hh:$mm';

    if (diff == 0) return 'Сегодня · $time';
    if (diff == 1) return 'Завтра · $time';
    if (diff == -1) return 'Вчера · $time';
    if (diff > 1 && diff < 7) return 'Через $diff ${_daysWord(diff)} · $time';

    const months = [
      'янв', 'фев', 'мар', 'апр', 'мая', 'июн',
      'июл', 'авг', 'сен', 'окт', 'ноя', 'дек',
    ];
    return '${dt.day} ${months[dt.month - 1]} · $time';
  }

  String _daysWord(int n) {
    if (n % 10 == 1 && n % 100 != 11) return 'день';
    if ([2, 3, 4].contains(n % 10) && ![12, 13, 14].contains(n % 100)) {
      return 'дня';
    }
    return 'дней';
  }

  String _peopleWord(int n) {
    if (n % 10 == 1 && n % 100 != 11) return 'человек';
    if ([2, 3, 4].contains(n % 10) && ![12, 13, 14].contains(n % 100)) {
      return 'человека';
    }
    return 'человек';
  }

  // ——— map bottom sheet (заглушка) ———
  void _showMapInProgressSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(
          color: _bgDeep,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.fromLTRB(
          20, 12, 20, MediaQuery.of(ctx).viewInsets.bottom + 28,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ручка
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // иконка
            Center(
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: _accent.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.map_outlined,
                  color: _accent,
                  size: 36,
                ),
              ),
            ),
            const SizedBox(height: 16),

            const Center(
              child: Text(
                'Карта в разработке',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 8),

            const Center(
              child: Text(
                'Скоро здесь будет карта с активностями рядом.\nПока можешь смотреть их списком.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _textMuted,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // кнопка закрытия
            SizedBox(
              height: 50,
              child: Material(
                color: _accent,
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(ctx);
                    setState(() => _isMapView = false);
                  },
                  borderRadius: BorderRadius.circular(14),
                  child: const Center(
                    child: Text(
                      'Понятно',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: _buildAppBar(),
      body: RefreshIndicator(
        onRefresh: _loadActivities,
        color: _accent,
        backgroundColor: _card,
        child: _buildBody(),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ——— AppBar с заголовком, переключателем и фильтрами ———
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: _bgDeep,
      elevation: 0,
      toolbarHeight: 160,
      title: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // верхняя строка: локация + заголовок + иконка поиска
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.location_on_rounded,
                            color: _textMuted, size: 12),
                        SizedBox(width: 4),
                        Text(
                          'Астана',
                          style: TextStyle(
                            color: _textMuted,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Активности',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: _card,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.04),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // переключатель Список / Карта
            _buildViewToggle(),
          ],
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(54),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (ctx, i) => _buildFilterChip(_filters[i]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildViewToggle() {
    return Container(
      height: 60,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: Colors.white.withOpacity(0.04)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildToggleButton(
              label: 'Список',
              icon: Icons.view_list_rounded,
              isSelected: !_isMapView,
              onTap: () => setState(() => _isMapView = false),
            ),
          ),
          Expanded(
            child: _buildToggleButton(
              label: 'Карта',
              icon: Icons.map_rounded,
              isSelected: _isMapView,
              onTap: () {
                setState(() => _isMapView = true);
                _showMapInProgressSheet();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? _accent : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : _textMuted,
              size: 14,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : _textMuted,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String name) {
    final isSelected = _selectedFilter == name;
    final meta = name == 'Все' ? null : _categoryMeta[name];

    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = name),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: isSelected
              ? (meta?.accent.withOpacity(0.15) ?? _accent.withOpacity(0.15))
              : _card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? (meta?.accent ?? _accent)
                : Colors.white.withOpacity(0.04),
            width: isSelected ? 1 : 0.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (meta != null) ...[
              Text(meta.emoji, style: const TextStyle(fontSize: 13)),
              const SizedBox(width: 6),
            ],
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

  // ——— тело экрана ———
  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: _accent, strokeWidth: 2.5),
      );
    }

    if (_error != null) {
      return _buildErrorState();
    }

    final items = _filteredActivities;
    if (items.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      itemCount: items.length,
      itemBuilder: (ctx, i) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: _buildActivityCard(items[i]),
      ),
    );
  }

  Widget _buildErrorState() {
    return ListView(
      children: [
        const SizedBox(height: 100),
        Center(
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: _accent.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.cloud_off_rounded,
              color: _accent,
              size: 32,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Center(
          child: Text(
            'Не удалось загрузить',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Проверь подключение и попробуй снова',
            textAlign: TextAlign.center,
            style: const TextStyle(color: _textMuted, fontSize: 13),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: TextButton(
            onPressed: _loadActivities,
            style: TextButton.styleFrom(
              backgroundColor: _card,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Повторить',
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      children: [
        const SizedBox(height: 80),
        Center(
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: _social.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.celebration_outlined,
              color: _social,
              size: 32,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Center(
          child: Text(
            'Пока ничего нет',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 6),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Стань первым — создай активность и\nпозови компанию',
            textAlign: TextAlign.center,
            style: TextStyle(color: _textMuted, fontSize: 13, height: 1.4),
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CreateActivity(),
                ),
              ).then((_) => _loadActivities());
            },
            style: TextButton.styleFrom(
              backgroundColor: _accent,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add_rounded, color: Colors.white, size: 18),
                SizedBox(width: 6),
                Text(
                  'Создать активность',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ——— карточка активности ———
  Widget _buildActivityCard(_ActivityData a) {
    final meta = _metaFor(a.category);
    final isFull = a.currentPeople >= a.maxPeople;
    final slotsLeft = a.maxPeople - a.currentPeople;

    return Material(
      color: _card,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: () {
          // TODO: переход к деталям активности
        },
        borderRadius: BorderRadius.circular(18),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withOpacity(0.04)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // обложка
              Stack(
                children: [
                  Container(
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(18),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [meta.gradientStart, meta.gradientEnd],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: 16,
                          top: 0,
                          bottom: 0,
                          child: Center(
                            child: Text(
                              meta.emoji,
                              style: const TextStyle(fontSize: 44),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // бейдж категории
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        a.category ?? 'Активность',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  // бейдж мест
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isFull
                            ? Colors.black.withOpacity(0.5)
                            : _success,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            isFull
                                ? 'Мест нет'
                                : 'Свободно $slotsLeft',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // контент
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // заголовок
                    Text(
                      a.title ?? 'Без названия',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // описание
                    if (a.description != null &&
                        a.description!.trim().isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        a.description!,
                        style: const TextStyle(
                          color: _textMuted,
                          fontSize: 13,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],

                    const SizedBox(height: 12),

                    // инфо-строки
                    Row(
                      children: [
                        _buildInfoPill(
                          icon: Icons.schedule_rounded,
                          text: _formatWhen(a.scheduledAt),
                          color: _accent,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildInfoPill(
                            icon: Icons.location_on_rounded,
                            text: a.location?.isNotEmpty == true
                                ? a.location!
                                : 'Место не указано',
                            color: _social,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // нижняя часть: участники + кнопка
                    Row(
                      children: [
                        // участники
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: _cardSoft,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.group_rounded,
                                color: _textMuted,
                                size: 14,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${a.currentPeople}/${a.maxPeople}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _peopleWord(a.maxPeople),
                                style: const TextStyle(
                                  color: _textMuted,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Spacer(),

                                                // кнопка
                                                // кнопка
                        Material(
                          color: _accent,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const Chat()),
                              );
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 9,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text(
                                    'Участвовать',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoPill({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // ——— bottom nav (как в Search.dart) ———
  Widget _buildBottomNav() {
    return BottomAppBar(
      color: _bgDeep,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavIcon(
              Icons.home_rounded,
              'Главная',
              true,
              () {},
            ),
            _buildNavIcon(
              Icons.confirmation_number_outlined,
              'Бронь',
              false,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Search()),
                );
              },
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CreateActivity()),
                ).then((_) => _loadActivities());
              },
              child: Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: _accent,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x66E93C35),
                      blurRadius: 16,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ),
            _buildNavIcon(
              Icons.chat_bubble_outline_rounded,
              'Чаты',
              false,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Chat()),
                );
              },
              hasNotification: true,
            ),
            _buildNavIcon(
              Icons.person_outline_rounded,
              'Профиль',
              false,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Profile()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavIcon(
    IconData icon,
    String label,
    bool isActive,
    VoidCallback onTap, {
    bool hasNotification = false,
  }) {
    final color = isActive ? _accent : _textMuted;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(icon, color: color, size: 22),
              if (hasNotification)
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _accent,
                      shape: BoxShape.circle,
                      border: Border.all(color: _bgDeep, width: 1.5),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ——— модель данных активности ———
class _ActivityData {
  final String id;
  final String? creatorId;
  final String? title;
  final String? description;
  final String? category;
  final String? location;
  final DateTime? scheduledAt;
  final int maxPeople;
  final int currentPeople;
  final DateTime? createdAt;

  _ActivityData({
    required this.id,
    this.creatorId,
    this.title,
    this.description,
    this.category,
    this.location,
    this.scheduledAt,
    this.maxPeople = 4,
    this.currentPeople = 1,
    this.createdAt,
  });

  factory _ActivityData.fromMap(Map<String, dynamic> m) {
    DateTime? parseDate(dynamic v) {
      if (v == null) return null;
      if (v is DateTime) return v.toLocal();
      return DateTime.tryParse(v.toString())?.toLocal();
    }

    int parseInt(dynamic v, int fallback) {
      if (v == null) return fallback;
      if (v is int) return v;
      return int.tryParse(v.toString()) ?? fallback;
    }

    return _ActivityData(
      id: m['id']?.toString() ?? '',
      creatorId: m['creator_id']?.toString(),
      title: m['title']?.toString(),
      description: m['description']?.toString(),
      category: m['category']?.toString(),
      location: m['location']?.toString(),
      scheduledAt: parseDate(m['scheduled_at']),
      maxPeople: parseInt(m['max_people'], 4),
      currentPeople: parseInt(m['current_people'], 1),
      createdAt: parseDate(m['created_at']),
    );
  }
}

// ——— мета категорий ———
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