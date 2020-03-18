import 'package:Software_Development/services/restuarant_api.dart';
import 'package:Software_Development/utils/colors.dart';
import 'package:Software_Development/utils/custom_stepper.dart';
import 'package:Software_Development/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class TripPage extends StatefulWidget {
  final int currentStep;
  final Map<String, dynamic> restaurantSelected;

  const TripPage({Key key, this.currentStep, this.restaurantSelected}) : super(key: key);
  
  @override
  _TripPageState createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  int _currentStep;
  List<Widget> _steps;
  String _transportMethod;
  Map<String, dynamic> _restaurantSelected;

  @override
  void initState() {
    super.initState();
    this._currentStep = this.widget.currentStep;
    this._transportMethod = '';
    this._steps = getChildren();
    this._restaurantSelected = this.widget.restaurantSelected;
  }

  @override
  Widget build(BuildContext context) {
    return CustomStepper(
      steps: this._steps,
      currentStep: this._currentStep,
      autoCheckLast: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[50],
        elevation: 0.0,
        leading: Padding(
          padding: EdgeInsets.only(top: 20.0, left: 15.0),
          child: IconButton(
            icon: Image.asset('assets/images/back_button.png'),
            onPressed: () => Navigator.pop(context),
            color: colors['Green'],
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20.0, right: 15.0),
            child: IconButton(
              icon: Image.asset('assets/images/settings.png'),
              onPressed: () => Navigator.of(context).pushNamed('/settings'),
              color: colors['Green'],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> getChildren() {
    List<Map<String, dynamic>> restaurants = RestaurantApi.getRestaurants();
    List<Map<String, dynamic>> topRatedRestaurants = RestaurantApi.getTopRatedRestaurants();
    return [
      Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: Text(
              'Choose Your Destination',
              style: TextStyle(
                color: colors['Green'],
                fontSize: 22.0,
              ),
            ),
          ),
          WidgetUtils.createSearchBar(
            description: 'Find Bars',
            list: restaurants,
            field: 'Name',
            content: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 32.0, bottom: 10.0),
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
                  children: List.generate(restaurants.length, (index) => 
                    WidgetUtils.createRestaurantCard(
                      restaurants.elementAt(index)['Name'],
                      restaurants.elementAt(index)['Rating'],
                      onPressed: (selected) {
                        if(selected) {
                          this._restaurantSelected = restaurants.elementAt(index);
                          next();
                        }
                      },
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
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
                SizedBox(
                  height: 183.0,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: RestaurantApi.topRatedSize(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: index == RestaurantApi.topRatedSize() - 1 ? EdgeInsets.only(left: 10.0) : EdgeInsets.only(right: 10.0),
                        child: WidgetUtils.createRestaurantCard(
                          topRatedRestaurants.elementAt(index)['Name'],
                          topRatedRestaurants.elementAt(index)['Rating'],
                          imageLocation: topRatedRestaurants.elementAt(index)['Image Location'] ?? null,
                          onPressed: (selected) {
                            if(selected) {
                              this._restaurantSelected = topRatedRestaurants.elementAt(index);
                              next();
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            onPressed: (name) => setState(() {
              this._currentStep = 1;
              this._restaurantSelected = restaurants.firstWhere((restaurant) => restaurant['Name'] == name);
            }),
          ),
        ],
      ),
      Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'More Info',
                style: TextStyle(
                  color: colors['Green'],
                  fontSize: 25.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Text(
                'Before you go, answer these few\nquestions to help us improve your\nexperience',
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              '1. How are you going to get back home?',
              style: TextStyle(
                color: colors['Green'],
                fontSize: 16.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 64.0),
                  child: IconButton(
                    icon: Image.asset('assets/images/lyft_logo.png'),
                    onPressed: () {
                      setState(() {
                        this._transportMethod = 'Lyft';
                        print(this._transportMethod);
                      });
                      next();
                    }, // Remember option that was clicked
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 64.0),
                  child: IconButton(
                    icon: Image.asset('assets/images/uber_logo.jpg'),
                    onPressed: () {
                      setState(() {
                        this._transportMethod = 'Uber';
                        print(this._transportMethod);
                      });
                      next();
                    },
                  ),
                ),
              ],
            ),
          ],
        )
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.check_circle,
                    color: colors['Green'],
                    size: 60.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Finished!',
                    style: TextStyle(
                      color: colors['Green'],
                      fontSize: 22.0,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: WidgetUtils.createButton(
                context, 
                'Continue My Trip', 
                colors['Green'],
                onPressed: () async {
                  String url = '';
                  Position currentPosition = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                  if(this._transportMethod == 'Uber') {
                    url = 'http://m.uber.com/ul/?client_id=bQTf94qfokNhhjLSmnYLnpkpnSCIA3kdS&action=setPickup&pickup[latitude]=${this._restaurantSelected['Latitude']}&pickup[longitude]=${this._restaurantSelected['Longitude']}&pickup[nickname]=${this._restaurantSelected['Name']}&dropoff[latitude]=${currentPosition.latitude}&dropoff[longitude]=${currentPosition.longitude}&dropoff[nickname]=Home';
                  } else{
                    url = 'https://lyft.com/ride?id=lyft&partner=J9V_pBP8uiZE&pickup[latitude]=${this._restaurantSelected['Latitude']}&pickup[longitude]=${this._restaurantSelected['Longitude']}&destination[latitude]=${currentPosition.latitude}&destination[longitude]=${currentPosition.longitude}';
                  }

                  if(await canLaunch(url)) {
                    await launch(url);
                  } else {
                    print('Could Not Launch $url');
                  }
                },
              ),
            )
          ],
        )
      ),
    ];
  }

  void next() {
    this._currentStep == this._steps.length - 1 ? goTo(0) : goTo(this._currentStep + 1);
  }

  void goTo(int step) {
    setState(() => this._currentStep = step);
  }
}