class RestaurantApi {
  static List<Map<String, dynamic>> _restaurants = getRestaurants();
  static List<Map<String, dynamic>> _topRatedRestaurants = getTopRatedRestaurants();

  static List<Map<String, dynamic>> getRestaurants() {
    return [
      {
        'Name': 'Beardslee Public House',
        'Rating': 4.2,
        'Image Location': 'assets/images/tsd1.png',
        'Latitude': 47.766330,
        'Longitude': -122.191400,
      },
      {
        'Name': 'McMenamins Tavern on the Square',
        'Rating': 4.3,
        'Image Location': 'assets/images/tsd2.png',
        'Latitude': 47.763371,
        'Longitude': -122.207748,
      },
      {
        'Name': 'The Hop and Hound - Craft Beer Bar',
        'Rating': 4.8,
        'Image Location': 'assets/images/tsd3.png',
        'Latitude': 47.760210,
        'Longitude': -122.205520,
      },
      {
        'Name': 'The Three Lions Pub',
        'Rating': 4.3,
        'Image Location': 'assets/images/tsd4.png',
        'Latitude': 47.759940,
        'Longitude': -122.204910,
      },
      {
        'Name': 'The Woodshop',
        'Rating': 4.2,
        'Image Location': 'assets/images/tsd5.png',
        'Latitude': 47.755219,
        'Longitude': -122.201103,
      },
      {
        'Name': 'The Bine Beer & Food',
        'Rating': 4.7,
        'Image Location': 'assets/images/tsd6.png',
        'Latitude': 47.7599711,
        'Longitude': 1,
      },
    ];
  }

  static List<Map<String, dynamic>> getTopRatedRestaurants() {
    List<Map<String, dynamic>> temp = getRestaurants();
    temp.sort((e1, e2) => (e2['Rating'] as double).compareTo((e1['Rating'] as double)));
    return temp;
  }

  static int size() {
    return RestaurantApi._restaurants.length;
  }

  static int topRatedSize() {
    return RestaurantApi._topRatedRestaurants.length;
  }
}