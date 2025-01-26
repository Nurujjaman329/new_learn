import 'package:flutter/material.dart';

class SearchableDropdown<T> extends StatefulWidget {
  final String hintText;
  final List<T> items;
  final String Function(T) itemLabelBuilder;
  final void Function(T?) onChanged;
  final T? selectedItem;

  const SearchableDropdown({
    Key? key,
    required this.hintText,
    required this.items,
    required this.itemLabelBuilder,
    required this.onChanged,
    this.selectedItem,
  }) : super(key: key);

  @override
  _SearchableDropdownState<T> createState() => _SearchableDropdownState<T>();
}

class _SearchableDropdownState<T> extends State<SearchableDropdown<T>> {
  late TextEditingController _searchController;
  late List<T> _filteredItems;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredItems = widget.items;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openSearchDialog() async {
    // Reset filtered items and clear the search field before showing the dialog
    _searchController.clear(); // Clear the search text
    _filteredItems = widget.items; // Reset to the full item list

    final selectedItem = await showDialog<T>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onChanged: (value) {
                    // Update filtered items inside the dialog state
                    setDialogState(() {
                      _filteredItems = widget.items
                          .where((item) => widget
                              .itemLabelBuilder(item)
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      return ListTile(
                        title: Text(widget.itemLabelBuilder(item)),
                        onTap: () => Navigator.pop(context, item),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    if (selectedItem != null) {
      widget.onChanged(selectedItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openSearchDialog,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Text(
          widget.selectedItem != null
              ? widget.itemLabelBuilder(widget.selectedItem!)
              : 'Select ${widget.hintText}',
          style: TextStyle(
            color: widget.selectedItem != null
                ? Colors.black
                : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}
