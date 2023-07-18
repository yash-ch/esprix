// create a stateful widget home
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'matrixControl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

// create home state
class _HomeState extends State<Home> {
  final TextEditingController _ipaddressController = TextEditingController();
  List<String> _storedIpAddressList = [];

  @override
  void initState() {
    super.initState();
    _loadStoredList();
  }

  _loadStoredList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _storedIpAddressList = prefs.getStringList('IPAddressList') ?? [];
      if (_storedIpAddressList.isNotEmpty) {
        _ipaddressController.text = _storedIpAddressList.first;
      }
    });
  }

  _saveList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('IPAddressList', _storedIpAddressList);
    _loadStoredList();
  }

  bool _isIpAddressListVisible = false;
  // build home widget and enclose the return in scaffold
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // add appbar
        appBar: AppBar(
          title: const Text('Esprix'),
          titleTextStyle: const TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Colors.black,
            fontFamily: 'montserrat',
          ),
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.info,
                color: Colors.grey,
                size: 30.0,
              ),
            ),
          ],
        ),
        // add body
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
                  padding: const EdgeInsets.all(20.0),
                  // color: Colors.grey[200],
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text("ESP IP address",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                                color: Colors.black54,
                                fontFamily: 'montserrat')),
                      ),
                      TextField(
                        controller: _ipaddressController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                          signed: false,
                        ),
                        decoration: InputDecoration(
                          hintText: '192.168.x.x',
                          labelStyle: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                            color: Colors.grey,
                            fontFamily: 'montserrat',
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          prefixIcon: const Icon(
                            Icons.wifi,
                            color: Colors.black54,
                            size: 30.0,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _ipaddressController.clear();
                              });
                            },
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.black54,
                              size: 24.0,
                            ),
                          ),
                        ),
                        onChanged: (value) {},
                        onSubmitted: (value) {
                          setState(() {
                            _storedIpAddressList.insert(0, value);
                            _saveList();
                          });
                        },
                      ),
                    ],
                  )),
              Container(
                margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text("Saved IP addresses",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                              color: Colors.black54,
                              fontFamily: 'montserrat')),
                    ),
                    _storedIpAddressList.isEmpty
                        ? const Center(child: Text('No saved IP addresses'))
                        : SizedBox(
                            height: _storedIpAddressList.length < 6 ? _storedIpAddressList.length*65 :  290.0,
                            child: ListView.builder(
                              itemCount: _storedIpAddressList.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  // color: Colors.transparent,
                                  elevation: 0.0,
                                  child: ListTile(
                                    title: Text(_storedIpAddressList[index]),
                                    onTap: () {
                                      setState(() {
                                        _ipaddressController.text =
                                            _storedIpAddressList[index];
                                        _isIpAddressListVisible = false;
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
              Container(
                //fix button to the buttom of the screen
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
                padding: const EdgeInsets.all(8.0),
                // color: Colors.grey[200],
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextButton(
                    onPressed: _ipaddressController.text.isEmpty
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MatrixControl()),
                            );
                          },
                    child: Text(
                      'Connect',
                      style: _ipaddressController.text.isEmpty
                          ? const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                              color: Colors.grey,
                              fontFamily: 'montserrat',
                            )
                          : const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                              color: Colors.black,
                              fontFamily: 'montserrat',
                            ),
                    )),
              )
            ],
          ),
        ));
  }
}
