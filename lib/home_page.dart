import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  Widget appBarTitle = Text(
    'search something',
    style: TextStyle(color: Colors.white),
  );
  Icon icon = Icon(
    Icons.search,
    color: Colors.white,
  );
  final TextEditingController _controller = TextEditingController();
  bool _isSearching = false;
  List<dynamic> _list = [];
  List<dynamic> searchResult = [];

  /// Build a customized appBar widget
  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: appBarTitle,
      actions: [
        IconButton(
          icon: icon,
          onPressed: () {
            setState(() {
              if (this.icon.icon == Icons.search) {
                this.icon = Icon(
                  Icons.close,
                  color: Colors.white,
                );
                this.appBarTitle = TextField(
                  controller: _controller,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      hintText: 'Search...',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      )),
                  onChanged: searchOperation,
                );
                _handleSearchStart();
              } else {
                _handleSearchEnd();
              }
            });
          },
        ),
      ],
    );
  }

  @override
  void initState() {
    value();
    super.initState();
  }

  /// create a list of searchable strings
  void value() {
    _list.add('Indian rupee');
    _list.add('United State dollar');
    _list.add('Australian dollar');
    _list.add('Euro');
    _list.add('British pound');
    _list.add('Japanese yen');
  }

  /// attach an event listener to the controller
  /// and check if the controller text isn't
  /// if yes, change the search flag (_isSaerching) to true
  void _handleSearchStart() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
        });
      } else {
        setState(() {
          _isSearching = true;
        });
      }
    });
  }

  /// stop seaching and show back the 
  /// original appBar text widget
  void _handleSearchEnd() {
    setState(() {
      this.icon = Icon(Icons.search, color: Colors.white);
      this.appBarTitle = Text(
        'Search something',
        style: TextStyle(color: Colors.white),
      );
      _isSearching = false;
      _controller.clear();
    });
  }

  /// populate the searchResult list with
  /// all the strings that match the searchText
  void searchOperation(String searchText) {
    searchResult.clear();
    if (_isSearching) {
      for (int i = 0; i < _list.length; i++) {
        String data = _list[i];
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          searchResult.add(data);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SafeArea(
        child: searchResult.length != 0 || _controller.text.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: searchResult.length,
                itemBuilder: (BuildContext context, int index) {
                  String listData = searchResult[index];
                  return ListTile(
                    title: Text(listData.toString()),
                  );
                },
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: _list.length,
                itemBuilder: (BuildContext context, int index) {
                  String listData = _list[index];
                  return ListTile(
                    title: Text(listData.toString()),
                  );
                }),
      ),
    );
  }
}
