import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: "Search",
              hintStyle: TextStyle(color: Colors.grey[500]),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  'lib/images/search.png',
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
