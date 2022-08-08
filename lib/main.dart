import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SharedPrefereceExample(),
      theme: ThemeData(
        // Define the default brightness and colors.

        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber),

        // Define the default font family.
        fontFamily: 'Tahoma',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 18.0, fontFamily: 'Hind'),
        ),
      ),
    );
  }
}

class SharedPrefereceExample extends StatefulWidget {
  const SharedPrefereceExample({Key? key}) : super(key: key);
  @override
  State<SharedPrefereceExample> createState() => _SharedPrefereceExampleState();
}

class _SharedPrefereceExampleState extends State<SharedPrefereceExample> {
  static const String kNumberPrefKey = 'number_pref';
  static const String kBoolPrefKey = 'bool_pref';

  int _numberPref = 0;
  bool _boolPref = false;
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) => {
          setState(() {
            _prefs = prefs;
            _loadNumberPref();
            _loadBoolPref();
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preference'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: Column(
          children: <Widget>[
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                TableRow(children: <Widget>[
                  const Text('Number Preference'),
                  Text('$_numberPref'),
                  ElevatedButton(
                    child: const Text('Increment'),
                    onPressed: () {
                      _setNumberPref(_numberPref + 1);
                    },
                  ),
                ]),
                TableRow(children: <Widget>[
                  const Text('Boolean Preference'),
                  Text('$_boolPref'),
                  ElevatedButton(
                    child: const Text('Toogle'),
                    onPressed: () {
                      _setBoolPref(!_boolPref);
                    },
                  ),
                ]),
              ],
            ),
            ElevatedButton(
              child: const Text('Reset Data'),
              onPressed: () {
                _resetDataPref();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _setNumberPref(int value) async {
    await _prefs?.setInt(kNumberPrefKey, value);
    _loadNumberPref();
  }

  Future<Null> _setBoolPref(bool value) async {
    await _prefs?.setBool(kBoolPrefKey, value);
    _loadBoolPref();
  }

  Future<Null> _resetDataPref() async {
    await _prefs?.remove(kNumberPrefKey);
    await _prefs?.remove(kBoolPrefKey);
    _loadNumberPref();
    _loadBoolPref();
  }

  void _loadNumberPref() {
    setState(() {
      _numberPref = _prefs?.getInt(kNumberPrefKey) ?? 0;
    });
  }

  void _loadBoolPref() {
    setState(() {
      _boolPref = _prefs?.getBool(kBoolPrefKey) ?? false;
    });
  }
}
