import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateActivity extends StatefulWidget {
  const CreateActivity({super.key});

  @override
  State<CreateActivity> createState() => _CreateActivityState();
}

class _CreateActivityState extends State<CreateActivity> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  String _selectedCategory = 'Тусовка';
  int _peopleCount = 4;
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _publish() async {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Введите название активности"), backgroundColor: Colors.red),
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
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Активность опубликована!"), backgroundColor: Colors.green),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 18, 33),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Создать активность',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 14, 13, 26),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.white24, height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text('Что делаем?', style: TextStyle(color: Color.fromARGB(255, 201, 201, 201), fontSize: 14)),
              const SizedBox(height: 8),
              TextField(
                controller: _titleController,  // добавил
                style: const TextStyle(color: Colors.white, fontSize: 24),
                decoration: InputDecoration(
                  hintText: 'Поход в кино',
                  hintStyle: TextStyle(color: const Color.fromARGB(255, 60, 70, 85), fontSize: 24, fontWeight: FontWeight.w500),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const SizedBox(height: 24),
              const Text('КАТЕГОРИЯ', style: TextStyle(color: Color.fromARGB(255, 120, 120, 120), fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryChip('Тусовка', Icons.local_bar),
                    const SizedBox(width: 8),
                    _buildCategoryChip('Спорт', Icons.sports_soccer),
                    const SizedBox(width: 8),
                    _buildCategoryChip('Еда', Icons.restaurant),
                    const SizedBox(width: 8),
                    _buildCategoryChip('Кино', Icons.movie),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(color: const Color(0xFF23262B), borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.notes, color: Colors.white.withOpacity(0.3), size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _descriptionController,  // добавил
                              maxLines: 3,
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                              decoration: InputDecoration(
                                hintText: 'Добавьте описание (опционально)...',
                                hintStyle: TextStyle(color: Colors.white.withOpacity(0.2)),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.white.withOpacity(0.05), height: 1),
                    _buildSelectionRow(
                      icon: Icons.calendar_today,
                      iconColor: const Color(0xFFE53935),
                      label: 'КОГДА',
                      value: 'Сегодня, 19:00',
                      trailing: Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.2)),
                    ),
                    Divider(color: Colors.white.withOpacity(0.05), height: 1),
                    // место — теперь с контроллером
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(color: const Color(0xFF4285F4).withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
                            child: const Icon(Icons.location_on, color: Color(0xFF4285F4), size: 20),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ГДЕ', style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 10, fontWeight: FontWeight.bold)),
                                TextField(
                                  controller: _locationController,  // добавил
                                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                                  decoration: InputDecoration(
                                    hintText: 'Укажите место',
                                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
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
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Количество людей', style: TextStyle(color: Color.fromARGB(255, 201, 201, 201), fontSize: 14)),
                  const Text('макс: 10', style: TextStyle(color: Color(0xFFE53935), fontSize: 14)),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(color: const Color(0xFF23262B), borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(  // добавил
                        onTap: () { if (_peopleCount > 2) setState(() => _peopleCount--); },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
                          child: const Icon(Icons.remove, color: Colors.white, size: 25),
                        ),
                      ),
                      Column(
                        children: [
                          Text('$_peopleCount', style: const TextStyle(color: Color.fromARGB(255, 201, 201, 201), fontSize: 24)),  // добавил
                          const Text('Человека', style: TextStyle(color: Color.fromARGB(255, 201, 201, 201), fontSize: 24)),
                        ],
                      ),
                      GestureDetector(  // добавил
                        onTap: () { if (_peopleCount < 10) setState(() => _peopleCount++); },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: const Color(0xFFE53935), borderRadius: BorderRadius.circular(8)),
                          child: const Icon(Icons.add, color: Colors.white, size: 25),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: Material(
                  color: const Color(0xFFE93C35),
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: _isLoading ? null : _publish,  // добавил
                    borderRadius: BorderRadius.circular(10),
                    child: Center(
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Опубликовать", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_right_alt, color: Colors.white, size: 20),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, IconData icon) {
    final isSelected = _selectedCategory == label;  // динамически
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = label),  // добавил
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE53935) : const Color(0xFF2C2F33),
          borderRadius: BorderRadius.circular(25),
          boxShadow: isSelected ? [BoxShadow(color: const Color(0xFFE53935).withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))] : null,
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required Widget trailing,
  }) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: iconColor.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 10, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}