// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

// class SearchTemplate extends StatefulWidget {
//   SearchTemplate({Key key}) : super(key: key);

//   @override
//   _SearchTemplateState createState() => _SearchTemplateState();
// }

// class _SearchTemplateState extends State<SearchTemplate> {
//   // controls the text label we use as a search bar
//   final TextEditingController _filter = TextEditingController();
//   final dio = Dio(); // for http requests
//   String _searchText = "";
//   List products = List(); // names we get from API
//   List filteredProducts = List(); // names filtered by search text
//   Icon _searchIcon = Icon(Icons.search);
//   Widget _appBarTitle = Text('ابحث بإسم المنتج');

//   void _getProduct() async {
//     final response = await dio.get('http://10.0.2.2:8000/api/v1/products');
//     List tempList = List();
//     for (int i = 0; i < response.data['results'].length; i++) {
//       tempList.add(response.data['results'][i]);
//     }

//     setState(() {
//       products = tempList;
//       filteredProducts = products;
//     });
//   }

//   void _searchPressed() {
//     setState(() {
//       if (this._searchIcon.icon == Icons.search) {
//         this._searchIcon = Icon(Icons.close);
//         this._appBarTitle = TextField(
//           controller: _filter,
//           decoration: InputDecoration(
//               prefixIcon: Icon(Icons.search), hintText: 'Search...'),
//         );
//       } else {
//         this._searchIcon = Icon(Icons.search);
//         this._appBarTitle = Text('Search Example');
//         filteredProducts = products;
//         _filter.clear();
//       }
//     });
//   }

//   ExamplePageState() {
//     _filter.addListener(() {
//       if (_filter.text.isEmpty) {
//         setState(() {
//           _searchText = "";
//           filteredProducts = products;
//         });
//       } else {
//         setState(() {
//           _searchText = _filter.text;
//         });
//       }
//     });
//   }

//   Widget _buildList() {
//     if (!(_searchText.isEmpty)) {
//       List tempList = List();
//       for (int i = 0; i < filteredProducts.length; i++) {
//         if (filteredProducts[i]['name']
//             .toLowerCase()
//             .contains(_searchText.toLowerCase())) {
//           tempList.add(filteredProducts[i]);
//         }
//       }
//       filteredProducts = tempList;
//     }
//     return ListView.builder(
//       itemCount: products == null ? 0 : filteredProducts.length,
//       itemBuilder: (BuildContext context, int index) {
//         return ListTile(
//           title: Text(filteredProducts[index]['name']),
//           onTap: () => print(filteredProducts[index]['name']),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _appBarTitle,
//       body: Container(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ExamplePage extends StatefulWidget {
  // ExamplePage({ Key key }) : super(key: key);
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  // final formKey =  GlobalKey<FormState>();
  // final key =  GlobalKey<ScaffoldState>();
  final TextEditingController _filter = TextEditingController();
  final dio = Dio();
  String _searchText = "";
  List names = List();
  List filteredNames = List();
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBarTitle = Text('إبحث بإسم المنتج');

  _ExamplePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    this._getNames();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: Container(
        child: _buildList(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
    );
  }

  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List tempList = List();
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(filteredNames[index]),
          onTap: () => print(filteredNames[index]),
        );
      },
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(Icons.close);
        this._appBarTitle = TextField(
          controller: _filter,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search), hintText: 'بحث ...'),
        );
      } else {
        this._searchIcon = Icon(Icons.search);
        this._appBarTitle = Text('إبحث بإسم المنتج');
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  void _getNames() async {
    final response = await dio.get('http://10.0.2.2:8000/api/v1/products');
    List tempList = List();
    for (int i = 0; i < response.data['data'][0].length; i++) {
      tempList.add(response.data['data'][0][i]['name']);
    }
    setState(() {
      names = tempList;
      names.shuffle();
      filteredNames = names;
    });
  }
}
