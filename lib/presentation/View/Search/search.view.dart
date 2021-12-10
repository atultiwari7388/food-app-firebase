import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          elevation: 3,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "Search for food",
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.search),
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
