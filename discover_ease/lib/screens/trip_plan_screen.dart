import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:chat_bubbles/chat_bubbles.dart';
class TripPlanPage extends StatefulWidget {
  @override
  _TripPlanPageState createState() => _TripPlanPageState();
}

class _TripPlanPageState extends State<TripPlanPage> {
  List<Trip> trips = [];
  TextEditingController tripNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTrips();
  }

  Future<void> _loadTrips() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tripsData = prefs.getString('trips');
    if (tripsData != null) {
      List<dynamic> decodedData = jsonDecode(tripsData);
      setState(() {
        trips = decodedData.map((item) => Trip.fromJson(item)).toList();
      });
    }
  }

  Future<void> _saveTrips() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> encodedData = trips.map((trip) => trip.toJson()).toList();
    await prefs.setString('trips', jsonEncode(encodedData));
  }

  void _addTrip(String name) {
    setState(() {
      trips.add(Trip(name: name, date: DateTime.now()));
    });
    _saveTrips();
  }

  void _editTrip(Trip trip, String newName) {
    setState(() {
      trip.name = newName;
    });
    _saveTrips();
  }

  void _deleteTrip(int index) {
    setState(() {
      trips.removeAt(index);
    });
    _saveTrips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trip Planner',
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/city/profile.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20), // Balonu biraz aşağı kaydır
                child: const BubbleSpecialOne(
                  isSender: false,
                  color: Color.fromRGBO(237, 246, 229, 1),
                  text: 'What kind of trip would you like to take? Share the details with us!',
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black, // Metin rengi siyah olarak ayarlandı
                  ),
                ),
              ),
              SizedBox(height: 36),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(237, 246, 229, 1),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 50),
                      child: TextField(
                        controller: tripNameController,
                        decoration: InputDecoration(
                          labelText: 'Trip Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          if (tripNameController.text.isNotEmpty) {
                            _addTrip(tripNameController.text);
                            tripNameController.clear();
                          }
                        },
                        child: Container(
                          child: Center(
                            child: Text('Add Trip'),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 42, 140, 122),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: trips.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        tileColor: Color.fromRGBO(237, 246, 229, 1),
                        title: Text(trips[index].name, style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(DateFormat('yMMMd').format(trips[index].date)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete, color: Color.fromARGB(255, 255, 82, 108)),
                              onPressed: () {
                                _deleteTrip(index);
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TripDetailPage(trip: trips[index]),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _editTripName(BuildContext context, Trip trip) async {
    final TextEditingController editController = TextEditingController(text: trip.name);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Trip Name'),
          content: TextField(
            controller: editController,
            decoration: InputDecoration(
              labelText: 'Trip Name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                _editTrip(trip, editController.text);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 42, 140, 122),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }
}

class Trip {
  String name;
  DateTime date;
  List<String> participants = [];
  List<String> places = [];
  List<String> events = [];

  Trip({required this.name, required this.date});

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      name: json['name'],
      date: DateTime.parse(json['date']),
    )
      ..participants = List<String>.from(json['participants'])
      ..places = List<String>.from(json['places'])
      ..events = List<String>.from(json['events']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date': date.toIso8601String(),
      'participants': participants,
      'places': places,
      'events': events,
    };
  }

  void addParticipant(String user) {
    participants.add(user);
  }

  void removeParticipant(String user) {
    participants.remove(user);
  }

  void editParticipant(String oldUser, String newUser) {
    int index = participants.indexOf(oldUser);
    if (index != -1) {
      participants[index] = newUser;
    }
  }

  void addPlace(String place) {
    places.add(place);
  }

  void removePlace(String place) {
    places.remove(place);
  }

  void editPlace(String oldPlace, String newPlace) {
    int index = places.indexOf(oldPlace);
    if (index != -1) {
      places[index] = newPlace;
    }
  }

  void addEvent(String event) {
    events.add(event);
  }

  void removeEvent(String event) {
    events.remove(event);
  }

  void editEvent(String oldEvent, String newEvent) {
    int index = events.indexOf(oldEvent);
    if (index != -1) {
      events[index] = newEvent;
    }
  }
}

class TripDetailPage extends StatefulWidget {
  final Trip trip;

  TripDetailPage({required this.trip});

  @override
  _TripDetailPageState createState() => _TripDetailPageState();
}

class _TripDetailPageState extends State<TripDetailPage> {
  TextEditingController participantController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController eventController = TextEditingController();
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.trip.date;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        widget.trip.date = pickedDate;
      });
    }
  }

  Widget _buildDetailSection(String title, List<String> items, TextEditingController controller, Function(String) addItem, Function(String) removeItem, Function(String, String) editItem) {
    return Container(
      margin: EdgeInsets.only(bottom: 16), // Kutular arası boşluk
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromRGBO(237, 246, 229, 1),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: title,
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: 150,
            child: ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  addItem(controller.text);
                  controller.clear();
                  setState(() {});
                }
              },
              child: Text('Add'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 42, 140, 122),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  tileColor: Color.fromRGBO(237, 246, 229, 1),
                  title: Text(items[index], style: TextStyle(fontWeight: FontWeight.bold)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete, color: Color.fromARGB(255, 255, 82, 108)),
                        onPressed: () {
                          removeItem(items[index]);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    TextEditingController editController = TextEditingController(text: items[index]);
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Edit $title'),
                          content: TextField(
                            controller: editController,
                            decoration: InputDecoration(
                              labelText: title,
                              border: OutlineInputBorder(),
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            ElevatedButton(
                              child: Text('Save'),
                              onPressed: () {
                                editItem(items[index], editController.text);
                                Navigator.of(context).pop();
                                setState(() {});
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 42, 140, 122),
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Details'),
      ),
      body: Stack(
        children: [
          // Arka plan resmi
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/city/profile.png"), // Arka plan resmi dosya yolu
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Trip Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      DateFormat('yMMMd').format(selectedDate ?? DateTime.now()),
                    ),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () => _selectDate(context),
                  ),
                  SizedBox(height: 16),
                  _buildDetailSection('Add Your Participants', widget.trip.participants, participantController, (String participant) {
                    setState(() {
                      widget.trip.addParticipant(participant);
                    });
                  }, (String participant) {
                    setState(() {
                      widget.trip.removeParticipant(participant);
                    });
                  }, (String oldParticipant, String newParticipant) {
                    setState(() {
                      widget.trip.editParticipant(oldParticipant, newParticipant);
                    });
                  }),
                  SizedBox(height: 16),
                  _buildDetailSection('Add The Places', widget.trip.places, placeController, (String place) {
                    setState(() {
                      widget.trip.addPlace(place);
                    });
                  }, (String place) {
                    setState(() {
                      widget.trip.removePlace(place);
                    });
                  }, (String oldPlace, String newPlace) {
                    setState(() {
                      widget.trip.editPlace(oldPlace, newPlace);
                    });
                  }),
                  SizedBox(height: 16),
                  _buildDetailSection('Add The Events', widget.trip.events, eventController, (String event) {
                    setState(() {
                      widget.trip.addEvent(event);
                    });
                  }, (String event) {
                    setState(() {
                      widget.trip.removeEvent(event);
                    });
                  }, (String oldEvent, String newEvent) {
                    setState(() {
                      widget.trip.editEvent(oldEvent, newEvent);
                    });
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}