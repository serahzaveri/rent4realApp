import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:househunter/Screens/hostHomePage.dart';
import 'package:househunter/Views/TextWidgets.dart';

class CreatePostingPage extends StatefulWidget {

  static final String routeName = '/createPostingPageRoute';

  CreatePostingPage({Key key}) : super(key: key);

  @override
  _CreatePostingPageState createState() => _CreatePostingPageState();
}

class _CreatePostingPageState extends State<CreatePostingPage> {

  String _houseType;
  final List<String> _houseTypes = [
    'Condo',
    'Apartment',
    'Townhouse'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(text: 'Create a Posting'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {}
          ),
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {},
          ),
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it in the middle of the parent.
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
            child: Column(
              //mainAxisAlignment centers the children vertically
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Please enter the following information:',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Posting name'
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 35.0),
                          child: DropdownButton(
                              //ensures that it takes entire width of screen
                              isExpanded: true,
                              value: _houseType,
                              hint: Text(
                                'Select a house type',
                                style: TextStyle(
                                    fontSize: 20.0,
                                ),
                              ),
                              items: _houseTypes.map((type) {
                                return DropdownMenuItem(
                                    value: type,
                                    child: Text(
                                      type,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    )
                                );
                              }).toList(),
                              onChanged: (value) {},
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'Rent'
                                  ),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0, bottom: 15.0),
                                child: Text(
                                  '\$ / per month',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Description'
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Address'
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'City'
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Country'
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 35.0),
                          child: Text(
                            'Beds',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
                            child:  Column(
                                children: <Widget>[
                                  FacilitiesWidget(type: 'Twin/Single', startValue: 0,),
                                  FacilitiesWidget(type: 'Double', startValue: 0,),
                                  FacilitiesWidget(type: 'Queen/King', startValue: 0,),
                                ],
                              ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 35.0),
                            child: Text(
                              'Bathrooms',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
                            child: Column(
                              children: <Widget>[
                                FacilitiesWidget(type: 'Half', startValue: 0,),
                                FacilitiesWidget(type: 'Full', startValue: 0,),
                              ],
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Amenities'
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 35.0),
                            child: Text(
                              'Images',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
                          child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: 2,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 25,
                                crossAxisSpacing: 25,
                                childAspectRatio: 3/2,
                              ),
                              itemBuilder: (context, index) {
                                if(index == 1) {
                                  return IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {},
                                    );
                                }
                                return MaterialButton(
                                  onPressed: () {} ,
                                  child: Image(
                                    image: AssetImage('assets/images/apartment1.jpg'),
                                    fit: BoxFit.fill,
                                  ),
                                );
                              }
                          ),
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FacilitiesWidget extends StatefulWidget {

  final String type;
  final int startValue;

  FacilitiesWidget({Key key, this.type, this.startValue}): super(key: key);

  @override
  _FacilitiesWidgetState createState() => _FacilitiesWidgetState();

}

class _FacilitiesWidgetState extends State<FacilitiesWidget> {

  int _value;

  @override
  void initState() {
    this._value = widget.startValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          widget.type,
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {},
            ),
            Text(
              this._value.toString(),
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }

}
