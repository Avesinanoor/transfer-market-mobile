import 'package:flutter/material.dart';
import 'package:transfer_market/widgets/app_drawer.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _thumbnailController = TextEditingController();
  final TextEditingController _clubController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  // Fields
  String? _selectedCategory;
  bool _isFeatured = false;

  final List<DropdownMenuItem<String>> _categoryItems = const [
    DropdownMenuItem(value: 'goalkeeper', child: Text('Goalkeeper')),
    DropdownMenuItem(value: 'center-back', child: Text('Center-Back')),
    DropdownMenuItem(value: 'left-back', child: Text('Left-Back')),
    DropdownMenuItem(value: 'right-back', child: Text('Right-Back')),
    DropdownMenuItem(value: 'center-midfielder', child: Text('Center-Midfielder')),
    DropdownMenuItem(value: 'attacking-midfielder', child: Text('Attacking-Midfielder')),
    DropdownMenuItem(value: 'defensive-midfielder', child: Text('Defensive-Midfielder')),
    DropdownMenuItem(value: 'left-winger', child: Text('Left-Winger')),
    DropdownMenuItem(value: 'right-winger', child: Text('Right-Winger')),
    DropdownMenuItem(value: 'striker', child: Text('Striker')),
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _thumbnailController.dispose();
    _clubController.dispose();
    _nationalityController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  bool _isValidUrl(String value) {
    final uri = Uri.tryParse(value);
    if (uri == null) return false;
    return (uri.scheme == 'http' || uri.scheme == 'https') && uri.host.isNotEmpty;
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text.trim();
      final int price = int.parse(_priceController.text.trim());
      final String description = _descriptionController.text.trim();
      final String thumbnail = _thumbnailController.text.trim();
      final String category = _selectedCategory!;
      final bool isFeatured = _isFeatured;
      final String club = _clubController.text.trim();
      final String nationality = _nationalityController.text.trim();
      final double height = double.parse(_heightController.text.trim());

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Player Registered'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Name: $name'),
                Text('Price: $price'),
                Text('Description: $description'),
                Text('Thumbnail: $thumbnail'),
                Text('Category: $category'),
                Text('Featured: ${isFeatured ? 'Yes' : 'No'}'),
                Text('Club: $club'),
                Text('Nationality: $nationality'),
                Text('Height: $height'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register Player',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                maxLength: 100,
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    if (v.isEmpty) return 'Name tidak boleh kosong';
                    if (v.length > 100) return 'Maksimal 100 karakter';
                    if (v.length < 2) return 'Minimal 2 karakter';
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    hintText: 'Masukkan angka bulat >= 0',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    if (v.isEmpty) return 'Price tidak boleh kosong';
                    final parsed = int.tryParse(v);
                    if (parsed == null) return 'Price harus berupa bilangan bulat';
                    if (parsed < 0) return 'Price tidak boleh negatif';
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  minLines: 3,
                  maxLines: 5,
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    if (v.isEmpty) return 'Description tidak boleh kosong';
                    if (v.length < 10) return 'Minimal 10 karakter';
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _thumbnailController,
                  decoration: const InputDecoration(
                    labelText: 'Thumbnail URL',
                    hintText: 'https://contoh.com/gambar.jpg',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    if (v.isEmpty) return 'Thumbnail tidak boleh kosong';
                    if (!_isValidUrl(v)) return 'Masukkan URL yang valid (http/https)';
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  items: _categoryItems,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (val) => setState(() => _selectedCategory = val),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Category harus dipilih'
                      : null,
                ),
                const SizedBox(height: 12),

                SwitchListTile(
                  title: const Text('Featured'),
                  value: _isFeatured,
                  onChanged: (val) => setState(() => _isFeatured = val),
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _clubController,
                  decoration: const InputDecoration(
                    labelText: 'Club',
                    border: OutlineInputBorder(),
                  ),
                  maxLength: 100,
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    if (v.isEmpty) return 'Club tidak boleh kosong';
                    if (v.length > 100) return 'Maksimal 100 karakter';
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _nationalityController,
                  decoration: const InputDecoration(
                    labelText: 'Nationality',
                    border: OutlineInputBorder(),
                  ),
                  maxLength: 100,
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    if (v.isEmpty) return 'Nationality tidak boleh kosong';
                    if (v.length > 100) return 'Maksimal 100 karakter';
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller: _heightController,
                  decoration: const InputDecoration(
                    labelText: 'Height (meter)',
                    hintText: 'Contoh: 1.75',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    if (v.isEmpty) return 'Height tidak boleh kosong';
                    final parsed = double.tryParse(v);
                    if (parsed == null) return 'Height harus berupa angka desimal';
                    if (parsed <= 0) return 'Height harus lebih dari 0';
                    if (parsed > 3.0) return 'Height tidak masuk akal (> 3.0m)';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _onSave,
                    icon: const Icon(Icons.save),
                    label: const Text('Save'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
