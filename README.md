## Material Search Bar

Material search bar with circular reveal animation as flutter widget like whatsapp search bar.

Inspired by WhatsApp SearchView and Android [MaterialSearchView](https://github.com/leoncydsilva/MaterialSearchView)

## Features

<div align:left;display:inline;>
<img width="360" height="800" src="https://github.com/kishandonga/flutter_material_search_bar/raw/main/images/demo.gif"/>
</div>

## Usage

```dart
import 'package:flutter_material_search_bar/flutter_material_search_bar.dart';

MaterialSearchBar(
  // @required
  controller: MaterialSearchBarController(),
  // @required
  appBar: AppBar(
    title: const Text('AppBar'),
  ),
  // @required
  textField: TextField(),
  // animation starting alignment
  alignment: Alignment.bottomRight,
  //to show the back button and customized as per need
  backButton: IconButton(
    icon: Icon(Icons.arrow_back),
  ),
  //to show the clear button and customized as per need
  clearButton: IconButton(
    icon: Icon(Icons.close),
  ),
),
```

## Parameter Details

### MaterialSearchBar(...)

| Parameter | Type | Required | Default Value | Details |
| :--- | :--- | :--- | :--- | :--- |
| controller | MaterialSearchBarController | Yes | | Required to use utility methods
| appBar | AppBar | Yes | | setup app bar inside the MaterialSearchBar same as used in the Scaffold
| textField | TextField | Yes | | Use as a text input for the MaterialSearchBar
| toolbarHeight | double | No | kToolbarHeight | AppBar customized then pass updated toolbar height
| color | Color | No | Theme.of(context).colorScheme.primary | color of the search bar
| backButton | Widget | No | SizedBox.shrink() | provide back button widget at left side
| clearButton | Widget | No | SizedBox.shrink() | provide clear button widget at right side
| alignment | Alignment | No | Alignment.center | provider animation starting alignment
| animationDuration | int | No | 300 milliseconds | provider animation duration value
| contentPadding | EdgeInsetsGeometry | No | EdgeInsets.zero | provider padding around search bar

### MaterialSearchBarController(...)

| Parameter | Type | Default Value | Details |
| :--- | :--- | :--- | :--- |
| isSearchBarVisible | bool | false | To check material search bar is visible or not
| toggleSearchBar() |  |  | Toggle search bar visibility

## Pending Task
1. To provide Offset support
2. Animation curve support

## Contribution
1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -m 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

## Support the Library

- You can support the library by staring it on Github && liking it on pub or report any bugs you encounter.
- also, if you have a suggestion or think something can be implemented in a better way, open an issue and let's talk about it.
