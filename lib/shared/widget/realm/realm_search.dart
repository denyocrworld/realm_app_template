import 'package:flutter/material.dart';

class RealmSearch extends StatefulWidget {
  final Function(String) onSearch;
  final String value;
  const RealmSearch({
    Key? key,
    required this.onSearch,
    required this.value,
  }) : super(key: key);

  @override
  State<RealmSearch> createState() => _RealmSearchState();
}

class _RealmSearchState extends State<RealmSearch> {
  FocusNode focusNode = FocusNode();
  _showDialog() async {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  initialValue: widget.value,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: Colors.grey[300]!,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.blueGrey[900],
                    ),
                    suffixIcon: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.sort,
                        color: Colors.blueGrey[900],
                      ),
                    ),
                  ),
                  onFieldSubmitted: (value) {
                    Navigator.pop(context);
                    widget.onSearch(value);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    Future.delayed(Duration(milliseconds: 200), () {
      focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _showDialog();
      },
      icon: Stack(
        children: [
          const Icon(
            Icons.search,
          ),
          if (widget.value.isNotEmpty)
            Positioned(
              right: 4,
              bottom: 0,
              child: const Icon(
                Icons.circle,
                color: Colors.red,
                size: 8.0,
              ),
            ),
        ],
      ),
    );
  }
}
