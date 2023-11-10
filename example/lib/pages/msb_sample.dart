import 'dart:convert';

import 'package:example/model/city.dart';
import 'package:example/utils/debounce.dart';
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
  final List<City> _searchList = [];
  final debounce = Debounce(milliseconds: 800);
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
    _searchList.addAll(_list);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_controller.isSearchBarVisible) {
          _controller.toggleSearchBar();
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
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
            onChanged: (text) {
              debounce.run(() {
                if (text.isNotEmpty) {
                  _searchList.clear();
                  for (var element in _list) {
                    if (element.state
                        .toLowerCase()
                        .contains(text.toLowerCase())) {
                      _searchList.add(element);
                    }
                  }
                } else {
                  _searchList.clear();
                  _searchList.addAll(_list);
                }
                if (mounted) {
                  setState(() {});
                }
              });
            },
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
              _searchList.clear();
              _searchList.addAll(_list);
              if (mounted) {
                setState(() {});
              }
            },
          ),
        ),
        body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_searchList[index].state),
              subtitle: Text(_searchList[index].name),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(height: 1),
          itemCount: _searchList.length,
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.close),
          onPressed: () {
            _searchQuery.text = '';
            _controller.toggleSearchBar();
          },
        ),
      ),
    );
  }
}
