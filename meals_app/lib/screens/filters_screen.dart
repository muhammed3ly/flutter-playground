import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const String routeName = '/filters';
  final Function setFilters;
  Map<String, bool> _filters;
  FiltersScreen(this.setFilters, this._filters);
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  Widget switchBuilder(
    String title,
    String subTitle,
    bool currentValue,
    Function fn,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      value: currentValue,
      onChanged: fn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => widget.setFilters(widget._filters),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                switchBuilder(
                  'Gluten-Free',
                  'Only include gluten-free meals.',
                  widget._filters['gluten'],
                  (val) {
                    setState(() {
                      widget._filters['gluten'] = val;
                    });
                  },
                ),
                switchBuilder(
                  'Lactose-Free',
                  'Only include Lactose-free meals.',
                  widget._filters['lactose'],
                  (val) {
                    setState(() {
                      widget._filters['lactose'] = val;
                    });
                  },
                ),
                switchBuilder(
                  'Vegetarian',
                  'Only include vegetarian meals.',
                  widget._filters['vegetarian'],
                  (val) {
                    setState(() {
                      widget._filters['vegetarian'] = val;
                    });
                  },
                ),
                switchBuilder(
                  'Vegan',
                  'Only include vegan meals.',
                  widget._filters['vegan'],
                  (val) {
                    setState(() {
                      widget._filters['vegan'] = val;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
