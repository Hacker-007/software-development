import 'package:Software_Development/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final String description;
  final List<Map<String, dynamic>> list;
  final String field;
  final Widget content;
  final List<Widget> actions;
  final Widget bottomNavigation;
  final void Function(String) onPressed;

  const CustomSearchBar({Key key, this.description, this.list, this.field, this.content, this.actions, this.bottomNavigation, this.onPressed}) : super(key: key);

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState(); 
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  TextEditingController _controller;
  bool _isSearching;
  String _searchText;
  List<String> _searchList;

  _CustomSearchBarState() {
    this._controller = TextEditingController();
    this._controller.addListener(() {
      print(this._isSearching);
      if(this._controller.text.isEmpty) {
        setState(() {
          this._isSearching = false;
          this._searchText = '';
        });
      } else {
        setState(() {
          this._isSearching = true;
          this._searchText = this._controller.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this._isSearching = false;
    this._searchText = '';
    this._searchList = _initializeSearchList();
  }
  
  @override
  Widget build(BuildContext context) {
    if(this.widget.actions == null && this.widget.bottomNavigation == null) {
      return Column(
        children: <Widget>[
          SizedBox(
            width: 240.0,
            height: 35.0,
            child: TextField(
              cursorColor: colors['Light Gray'],
              controller: this._controller,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide(color: colors['Light Gray']),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide(color: colors['Light Gray']),
                ),
                labelText: this.widget.description,
                labelStyle: TextStyle(
                  color: colors['Purple'],
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color.fromRGBO(182, 190, 212, 1.0),
                )
              ),
            ),
          ),
          Stack(
            children: <Widget>[
              this.widget.content,
              Align(
                alignment: Alignment.topCenter,
                child: this._isSearching ? _generateSearchListWidget() : Container(),
              ),
            ],
          ),
        ],
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey[50],
          elevation: 0.0,
          centerTitle: true,
          title: SizedBox(
            width: 240.0,
            height: 35.0,
            child: TextField(
              cursorColor: colors['Light Gray'],
              controller: this._controller,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide(color: colors['Light Gray']),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide(color: colors['Light Gray']),
                ),
                labelText: this.widget.description,
                labelStyle: TextStyle(
                  color: colors['Purple'],
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color.fromRGBO(182, 190, 212, 1.0),
                )
              ),
            ),
          ),
          actions: this.widget.actions,
        ),
        body: Stack(
          children: <Widget>[
            this.widget.content,
            Align(
              alignment: Alignment.topCenter,
              child: this._isSearching ? _generateSearchListWidget() : Container(),
            ),
          ],
        ),
        bottomNavigationBar: this.widget.bottomNavigation,
      );
    }
  }

  List<String> _initializeSearchList() {
    return this.widget.list
                      .map((map) => map[this.widget.field] as String)
                      .toList();
  }

  List<String> _generateSearchList() {
    if(this._searchText.isEmpty) {
      return this._searchList;
    } else {
      List<String> _list = List();
      for (int i = 0; i < this._searchList.length; i++) {
        String result = this._searchList.elementAt(i);
        if(result.toLowerCase().contains(this._searchText.toLowerCase())) {
          _list.add(result);
        }
      }

      return _list;
    }
  }

  Widget _generateSearchListWidget() {
    print('_isSearching: ${this._isSearching}, _searchText: ${this._searchText}');
    List<String> _results = _generateSearchList();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _results.isEmpty == null ? 0 : _results.length,
      itemBuilder: (context, index) =>
        Container(
          height: 50.0,
          width: 25.0,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
          ),
          child: ListTile(
            onTap: () {
              setState(() {
                this._searchText = _results.elementAt(index);
                this._controller.text = this._searchText;
                this._isSearching = false;
              });

              if(this.widget.onPressed != null) {
                this.widget.onPressed(_results.elementAt(index));
              }
            },
            title: Text(
              _results.elementAt(index),
              style: TextStyle(
                color: colors['Light Grey'],
              ),
            ),
          ),
        ),
    );
  }
}