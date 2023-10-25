import 'dart:convert';

import 'package:example/model/city.dart';
import 'package:flutter/material.dart';
import 'package:material_search_bar/material_search_bar.dart';

class MaterialSearchBarSample extends StatefulWidget {
  const MaterialSearchBarSample({super.key});

  @override
  State<MaterialSearchBarSample> createState() =>
      _MaterialSearchBarSampleState();
}

class _MaterialSearchBarSampleState extends State<MaterialSearchBarSample> {
  final List<City> _list = [];

  final MaterialSearchBarController _controller = MaterialSearchBarController();
  final TextEditingController _searchQuery = TextEditingController();

  @override
  void initState() {
    _getCityList();
    super.initState();
  }

  void _getCityList() async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/cities.json");
    List<dynamic> jsonResult = json.decode(data);
    for (var element in jsonResult) {
      _list.add(City.fromMap(element));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MaterialSearchBar(
        controller: _controller,
        appBar: AppBar(
          title: const Text('MSB with AppBar'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                _controller.toggleSearchBar();
              },
            ),
          ],
        ),
        color: Colors.white,
        alignment: Alignment.bottomRight,
        textField: TextField(
          onChanged: (text) {},
          controller: _searchQuery,
          cursorColor: Colors.black,
          style: const TextStyle(
            fontSize: 18.0,
            color: Colors.black,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        backButton: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            _searchQuery.text = '';
            _controller.toggleSearchBar();
          },
        ),
        clearButton: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            _searchQuery.text = '';
          },
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_list[index].state),
            subtitle: Text(_list[index].name),
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(height: 1),
        itemCount: _list.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.close),
        onPressed: () {
          _controller.toggleSearchBar();
        },
      ),
    );
  }
}
