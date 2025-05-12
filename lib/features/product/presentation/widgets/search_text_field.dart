import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final Function()? onClear;

  const SearchTextField({
    super.key,
    required this.controller,
    this.onChanged,
    this.onClear,
    // ignore: unused_element
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      TextField(
        controller: controller,
        onChanged: (value) {
          onChanged?.call(value);
        },

        decoration: InputDecoration(
          hintText: "Search Product",

          suffixIcon: IconButton(
            onPressed: () => onClear?.call(),
            icon: const Icon(Icons.clear),
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    ],
  );
}
