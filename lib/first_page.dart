import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  FirstPage({Key key}) : super(key: key);
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<bool> checkboxes = [false, false, false];
  int _groupRadio = -1;
  bool _switch = false;
  double _slider = 10;
  String title = 'date value';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 3,
      length: 4,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.date_range),
          onPressed: () async {
            final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1990, 1),
                lastDate: DateTime(2030, 1));
            print(date);
            setState(() {
              title =
                  '${date.year.toString()}-${date.month.toString()}-${date.day.toString()}';
            });
          },
        ),
        appBar: AppBar(
          title: Text('$title'),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'checkbox',
                icon: Icon(Icons.add_to_drive_sharp),
              ),
              Tab(
                text: 'radio',
                icon: Icon(Icons.airline_seat_recline_extra),
              ),
              Tab(
                text: 'switch',
                icon: Icon(Icons.web_asset_sharp),
              ),
              Tab(
                text: 'slider',
                icon: Icon(Icons.control_point),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  for (int i = 0; i < checkboxes.length; i++)
                    CheckboxListTile(
                      title: Text('data'),
                      tristate: i == 0,
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          checkboxes[i] = value;
                        });
                      },
                      value: checkboxes[i],
                      activeColor: Color(0xFF6200EE),
                    ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  for (var i = 0; i < 5; i++)
                    Column(
                      children: [
                        RadioListTile(
                          title: Text('data'),
                          value: i,
                          groupValue: _groupRadio,
                          onChanged: (value) {
                            setState(() {
                              _groupRadio = value;
                            });
                          },
                          activeColor: Color(0xFF6200EE),
                        ),
                        Divider(
                          color: Colors.grey,
                          indent: 5,
                          endIndent: 5,
                          thickness: 2,
                          height: 10,
                        )
                      ],
                    ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Switch(
                value: _switch,
                activeColor: Color(0xFF6200EE),
                onChanged: (value) {
                  setState(() {
                    _switch = value;
                  });
                },
              ),
            ),
            Container(
              // width: 100,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Slider(
                      value: _slider,
                      min: 0,
                      max: 100,
                      label: _slider.round().toString(),
                      divisions: 10,
                      onChanged: (value) {
                        if (value == 50) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              action: SnackBarAction(
                                label: 'hide',
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                },
                              ),
                              content: Text(
                                'half slider',
                              ),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                        setState(() {
                          _slider = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                      flex: 5,
                      child: ListView.builder(
                        itemCount: _slider.toInt(),
                        itemBuilder: (context, index) => ListTile(
                          leading: Icon(Icons.home),
                          title: Text('home'),
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
