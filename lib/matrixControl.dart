//create a stateful widget
import 'package:esprix/global_state_controller.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MatrixControl extends StatefulWidget {
  //get the ip address from the home page
  final String ipAddress;
  const MatrixControl({Key? key, required this.ipAddress}) : super(key: key);

  @override
  _MatrixControlState createState() => _MatrixControlState();
}

class _MatrixControlState extends State<MatrixControl> {
  //create a dictionary to store the data
  Map<String, dynamic> data = {
    "Animation in": "",
    "Animation out": "",
    "Text": "",
    "Speed": 0,
    "Pause": 0,
    "Position": ""
  };

  //create a list to store the data
  List<Map<String, dynamic>> textList = [];

  void textAddDialogBox(bool edit, [int? index]) {
    final TextEditingController _textController = TextEditingController();
    final TextEditingController _speedController = TextEditingController();
    final TextEditingController _pauseController = TextEditingController();

    _textController.text = data["Text"];
    _speedController.text = data["Speed"].toString();
    _pauseController.text = data["Pause"].toString();

    Map<String, String> animations = {
      "PA_NO_EFFECT": "No Effect",
      "PA_SCROLL_LEFT": "Scroll Left",
      "PA_SCROLL_RIGHT": "Scroll Right",
      "PA_SCROLL_UP": "Scroll Up",
      "PA_SCROLL_DOWN": "Scroll Down",
      "PA_SCROLL_UP_LEFT": "Scroll Up Left",
      "PA_SCROLL_UP_RIGHT": "Scroll Up Right",
      "PA_SCROLL_DOWN_LEFT": "Scroll Down Left",
      "PA_SCROLL_DOWN_RIGHT": "Scroll Down Right",
      "PA_MESH": "Mesh",
      "PA_SCROLL_IN_OUT": "Scroll In Out",
      "PA_OPENING_CURSOR": "Opening Cursor",
      "PA_OPENING": "Opening",
      "PA_CLOSING_CURSOR": "Closing Cursor",
      "PA_CLOSING": "Closing",
      "PA_GROW_UP": "Grow Up",
      "PA_GROW_RIGHT": "Grow Right",
      "PA_WIPE_CURSOR": "Wipe Cursor",
      "PA_WIPE": "Wipe",
      "PA_RANDOM": "Random",
      "PA_PRINT": "Print",
      "PA_SCAN_HORIZ": "Scan Horizontal",
      "PA_SCAN_VERT": "Scan Vertical",
      "PA_SLICE": "Slice",
      "PA_BLINDS": "Blinds",
      "PA_FADE ": "Fade",
      "PA_SPRITE ": "Sprite",
    };

    //open up a dialog box to enter the text, 3 drop down select and 2 number input and map the data via dictionary and store in textList
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return SingleChildScrollView(
              child: AlertDialog(
                title: const Text("Add Text"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Text",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                            color: Colors.black54,
                            fontFamily: 'montserrat')),
                    TextField(
                      controller: _textController,
                      decoration:
                          const InputDecoration(hintText: "Enter the text"),
                      onChanged: (value) {
                        data["Text"] = value;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    const Text("Animation in",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                            color: Colors.black54,
                            fontFamily: 'montserrat')),
                    DropdownButton(
                      //set value to the selected item
                      value: data["Animation in"].length == 0
                          ? "PA_SCROLL_RIGHT"
                          : data["Animation in"],
                      //items for the drop down menu via list mapping
                      items: animations.entries.map((entry) {
                        return DropdownMenuItem<String>(
                          value: entry.key,
                          child: Text(entry.value),
                        );
                      }).toList(),

                      onChanged: (value) {
                        //set the drop doen menu value to the selected item
                        setState(() {
                          data["Animation in"] = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10.0),
                    const Text("Animation out",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                            color: Colors.black54,
                            fontFamily: 'montserrat')),
                    DropdownButton(
                      //set value to the selected item
                      value: data["Animation out"].length == 0
                          ? "PA_SCROLL_RIGHT"
                          : data["Animation out"],
                      //items for the drop down menu via list mapping
                      items: animations.entries.map((entry) {
                        return DropdownMenuItem<String>(
                          value: entry.key,
                          child: Text(entry.value),
                        );
                      }).toList(),

                      onChanged: (value) {
                        //set the drop doen menu value to the selected item
                        setState(() {
                          data["Animation out"] = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10.0),
                    const Text("Speed",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                            color: Colors.black54,
                            fontFamily: 'montserrat')),
                    TextField(
                      controller: _speedController,
                      decoration: const InputDecoration(hintText: "0"),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          data["Speed"] = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10.0),
                    const Text("Pause",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                            color: Colors.black54,
                            fontFamily: 'montserrat')),
                    TextField(
                      controller: _pauseController,
                      decoration: const InputDecoration(hintText: "0"),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          data["Pause"] = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10.0),
                    const Text("Position",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                            color: Colors.black54,
                            fontFamily: 'montserrat')),
                    //create a drop down menu
                    DropdownButton(
                      //set value to the selected item
                      value: data["Position"] == "" ? "Left" : data["Position"],
                      items: const [
                        DropdownMenuItem(
                          child: Text("Left"),
                          value: "Left",
                        ),
                        DropdownMenuItem(
                          child: Text("Center"),
                          value: "Center",
                        ),
                        DropdownMenuItem(
                          child: Text("Right"),
                          value: "Right",
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          data["Position"] = value;
                        });
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        //close the dialog box
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel")),
                  TextButton(
                      onPressed: () {
                        sendDataToESP8266(context, data, widget.ipAddress);
                        // Navigator.of(context).pop();
                      },
                      child: const Text("Display")),
                  TextButton(
                      onPressed: () {
                        if (edit) {
                          GlobalStateController.state
                              .updateTextListAtIndex(index!, Map.from(data));
                          StorageController().putTextList(
                              GlobalStateController.state.textList.value);
                        } else {
                          //store the data in the list as a dictionary
                          if (data["animation in"] == "") {
                            data["animation in"] = "PA_SCROLL_RIGHT";
                          }
                          if (data["animation out"] == "") {
                            data["animation out"] = "PA_SCROLL_RIGHT";
                          }
                          if (data["position"] == "") {
                            data["position"] = "Left";
                          }
                          GlobalStateController.state
                              .addToTextList(Map.from(data));
                          StorageController().putTextList(
                              GlobalStateController.state.textList.value);
                        }
                        //snackbar to show the text is saved
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Text saved!'),
                          ),
                        );
                        //close the dialog box
                        // Navigator.of(context).pop();
                      },
                      child: Text(edit ? "Save" : "Add")),
                ],
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    textList = StorageController().getTextList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dot Matrix Controller'),
        titleTextStyle: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
          color: Colors.black,
          fontFamily: 'montserrat',
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text("IP Address: ${widget.ipAddress}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      color: Colors.black54,
                      fontFamily: 'montserrat')),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: IconButton(
                onPressed: () {
                  data["Text"] = "";
                  data["Speed"] = 0;
                  data["Pause"] = 0;
                  data["Position"] = "Center";
                  data["Animation in"] = "PA_SCROLL_RIGHT";
                  data["Animation out"] = "PA_SCROLL_LEFT";

                  textAddDialogBox(false);
                },
                icon: const Icon(Icons.add),
                iconSize: 50.0,
                color: Colors.black54,
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              padding: const EdgeInsets.only(top: 10.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20.0),
              ),
              //child widget to display the text from the list
              child: Column(
                children: [
                  const Text("Saved Texts",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                          color: Colors.black54,
                          fontFamily: 'montserrat')),
                  ValueListenableBuilder<List<Map<String, dynamic>>>(
                      valueListenable: GlobalStateController.state.textList,
                      builder: (context, _testList, child) {
                        if (_testList.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text("No Saved Texts",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.0,
                                    color: Colors.black54,
                                    fontFamily: 'montserrat')),
                          );
                        }
                        return SizedBox(
                          height: _testList.length < 4
                              ? _testList.length * 110.0
                              : 390,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _testList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      data["Text"] = _testList[index]["Text"];
                                      data["Speed"] = _testList[index]["Speed"];
                                      data["Pause"] = _testList[index]["Pause"];
                                      data["Position"] =
                                          _testList[index]["Position"];
                                      data["Animation in"] =
                                          _testList[index]["Animation in"];
                                      data["Animation out"] =
                                          _testList[index]["Animation out"];
                                    });
                                    textAddDialogBox(true, index);
                                  },
                                  child: ListTile(
                                    title: Text(_testList[index]["Text"]),
                                    subtitle: Text(
                                        "Animation in: ${_testList[index]["Animation in"]}\nAnimation out: ${_testList[index]["Animation out"]}\nSpeed: ${_testList[index]["Speed"]}\nPause: ${_testList[index]["Pause"]}\nPosition: ${_testList[index]["Position"]}"),
                                    trailing: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          // textList.removeAt(index);
                                          GlobalStateController.state
                                              .removeFromTextList(index);
                                          StorageController().putTextList(
                                              GlobalStateController.state
                                                  .textList.value);
                                        });
                                      },
                                      icon: const Icon(Icons.delete),
                                      color: Colors.red,
                                    ),
                                  ));
                            },
                          ),
                        );
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> sendDataToESP8266(
    context, Map<String, dynamic> jsonData, String ipAddress) async {
  final url = Uri.parse(
      'http://$ipAddress/esprix'); // Replace 'path' with your ESP8266 server endpoint

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(jsonData),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data sent successfully!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to send data!'),
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Failed to send data!'),
      ),
    );
  }
}

bool connectionStatus(String ipAddress) {
  Socket.connect(ipAddress, 80, timeout: const Duration(seconds: 5))
      .then((socket) {
    socket.destroy();
    return true;
  }).catchError((error) {
    return false;
  });
  return false;
}
