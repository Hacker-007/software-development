import 'package:Software_Development/services/restuarant_api.dart';
import 'package:Software_Development/utils/colors.dart';
import 'package:Software_Development/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  List<Map<String, dynamic>> _restaurants = RestaurantApi.getRestaurants();
  List<Map<String, dynamic>> _topRatedRestaurants = RestaurantApi.getTopRatedRestaurants();

  @override 
  Widget build(BuildContext context) {
    return WidgetUtils.createSearchBar(
      description: 'Find Bars',
      list: this._restaurants,
      field: 'Name',
      content: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 32.0, bottom: 10.0, left: 23.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Bars Nearby',
                    style: TextStyle(
                      color: colors['Purple'],
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              Wrap(
                spacing: 10.0,
                children: List.generate(this._restaurants.length, (index) => 
                  WidgetUtils.createRestaurantCard(
                    this._restaurants.elementAt(index)['Name'],
                    this._restaurants.elementAt(index)['Rating'],
                    onPressed: (selected) {
                      Navigator.of(context).pushNamed(
                        '/trip',
                        arguments: {
                          'currentStep': 1,
                          'restaurantSelected': this._restaurants.elementAt(index),
                        },
                      );
                    },
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 23.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Top Rated',
                    style: TextStyle(
                      color: colors['Purple'],
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 23.0),
                child: SizedBox(
                  height: 183.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: RestaurantApi.topRatedSize(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: index == RestaurantApi.topRatedSize() - 1 ? EdgeInsets.only(left: 10.0) : EdgeInsets.only(right: 10.0),
                        child: WidgetUtils.createRestaurantCard(
                          this._topRatedRestaurants.elementAt(index)['Name'],
                          this._topRatedRestaurants.elementAt(index)['Rating'],
                          imageLocation: this._topRatedRestaurants.elementAt(index)['Image Location'] ?? null,
                          onPressed: (selected) {
                            Navigator.of(context).pushNamed(
                              '/trip',
                              arguments: {
                                'currentStep': 1,
                                'restaurantSelected': this._topRatedRestaurants.elementAt(index),
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
          WidgetUtils.createIconButton(context, Icon(Icons.settings), 'settings'),
      ],
      bottomNavigation: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          WidgetUtils.createIconButton(context, Icon(Icons.place), 'trip', iconSize: 38),
          // WidgetUtils.createIconButton(context, Icon(Icons.calendar_today), 'calendar', iconSize: 38),
          WidgetUtils.createIconButton(context, Icon(Icons.account_circle), 'account', iconSize: 38),
          // WidgetUtils.createIconButton(context, Icon(Icons.people), 'friends', iconSize: 38),
        ],
      ),
      onPressed: (name) {
        Navigator.of(context).pushNamed(
          '/trip',
          arguments: {
            'currentStep': 1,
            'restaurantSelected': this._restaurants.firstWhere((restaurant) => restaurant['Name'] == name),
          },
        );
      }
    );
  }
}