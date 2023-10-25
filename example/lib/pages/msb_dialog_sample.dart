import 'dart:convert';

import 'package:example/model/city.dart';
import 'package:flutter/material.dart';
import 'package:material_search_bar/material_search_bar.dart';

class MaterialSearchBarDialogSample extends StatefulWidget {
  const MaterialSearchBarDialogSample({super.key});

  @override
  State<MaterialSearchBarDialogSample> createState() =>
      _MaterialSearchBarDialogSampleState();
}

class _MaterialSearchBarDialogSampleState
    extends State<MaterialSearchBarDialogSample> {
  final List<City> _list = [];
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
      appBar: AppBar(
        title: const Text('MSB With Dialog'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showMaterialSearchBarDialog(
                context,
                alignment: Alignment.bottomRight,
                color: Colors.white,
                textField: TextField(
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
                      hintStyle: TextStyle(fontSize: 18.0, color: Colors.grey)),
                ),
                backButton: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                clearButton: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _searchQuery.text = '';
                  },
                ),
              );
            },
          ),
        ],
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
        onPressed: () {},
      ),
    );
  }
}
