import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:discover_ease/widgets/bottom_navbar.dart';

void main() {
  runApp(DiscoverEaseApp());
}

class DiscoverEaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DiscoverEase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TripPlanPage(),
    );
  }
}

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
          margin: EdgeInsets.only(bottom: 16),
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
     // Kenarlık rengi ve kalınlığını buradan ayarlayabilirsiniz
  ),
            tileColor:Color.fromRGBO(237, 246, 229, 1),
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
      bottomNavigationBar: BottomNavBar(), // Bottom navigation bar eklendi
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
                backgroundColor:  Color.fromARGB(255, 42, 140, 122),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.trip.name} Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text(selectedDate == null
                    ? 'Select Date'
                    : DateFormat('yMMMd').format(selectedDate!)),
                style: ElevatedButton.styleFrom(
                  backgroundColor:  Color.fromARGB(255, 42, 140, 122),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              _buildSectionTitle('Participants'),
              TextField(
                controller: participantController,
                decoration: InputDecoration(
                  labelText: 'Add ',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  if (participantController.text.isNotEmpty) {
                    setState(() {
                      widget.trip.addParticipant(participantController.text);
                      participantController.clear();
                    });
                    _saveTrips();
                  }
                },
                child: Text('Add '),
                style: ElevatedButton.styleFrom(
                  backgroundColor:  Color.fromARGB(255, 42, 140, 122),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              _buildList(widget.trip.participants, (participant) {
                return _buildListItem(
                  participant,
                  onEdit: () => _editParticipant(context, participant),
                  onDelete: () {
                    setState(() {
                      widget.trip.removeParticipant(participant);
                    });
                    _saveTrips();
                  },
                );
              }),
              SizedBox(height: 16),
              _buildSectionTitle('Places'),
              TextField(
                controller: placeController,
                decoration: const InputDecoration(
                  labelText: 'Add',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  if (placeController.text.isNotEmpty) {
                    setState(() {
                      widget.trip.addPlace(placeController.text);
                      placeController.clear();
                    });
                    _saveTrips();
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
              _buildList(widget.trip.places, (place) {
                return _buildListItem(
                  place,
                  onEdit: () => _editPlace(context, place),
                  onDelete: () {
                    setState(() {
                      widget.trip.removePlace(place);
                    });
                    _saveTrips();
                  },
                );
              }),
              SizedBox(height: 16),
              _buildSectionTitle('Events'),
              TextField(
                controller: eventController,
                decoration: InputDecoration(
                  labelText: 'Add ',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  if (eventController.text.isNotEmpty) {
                    setState(() {
                      widget.trip.addEvent(eventController.text);
                      eventController.clear();
                    });
                    _saveTrips();
                  }
                },
                child: Text('Add '),
                style: ElevatedButton.styleFrom(
                  backgroundColor:Color.fromARGB(255, 42, 140, 122),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              _buildList(widget.trip.events, (event) {
                return _buildListItem(
                  event,
                  onEdit: () => _editEvent(context, event),
                  onDelete: () {
                    setState(() {
                      widget.trip.removeEvent(event);
                    });
                    _saveTrips();
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildList(List<String> items, Widget Function(String) itemBuilder) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return itemBuilder(items[index]);
      },
    );
  }

  Widget _buildListItem(String item, {required VoidCallback onEdit, required VoidCallback onDelete}) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(item, style: TextStyle(fontWeight: FontWeight.normal)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.black),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.redAccent),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editParticipant(BuildContext context, String oldParticipant) async {
    final TextEditingController editController = TextEditingController(text: oldParticipant);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Participant'),
          content: TextField(
            controller: editController,
            decoration: InputDecoration(
              labelText: 'Participant Name',
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
                setState(() {
                  widget.trip.editParticipant(oldParticipant, editController.text);
                });
                Navigator.of(context).pop();
                _saveTrips();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _editPlace(BuildContext context, String oldPlace) async {
    final TextEditingController editController = TextEditingController(text: oldPlace);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Place'),
          content: TextField(
            controller: editController,
            decoration: InputDecoration(
              labelText: 'Place Name',
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
                setState(() {
                  widget.trip.editPlace(oldPlace, editController.text);
                });
                Navigator.of(context).pop();
                _saveTrips();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _editEvent(BuildContext context, String oldEvent) async {
    final TextEditingController editController = TextEditingController(text: oldEvent);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Event'),
          content: TextField(
            controller: editController,
            decoration: InputDecoration(
              labelText: 'Event Name',
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
                setState(() {
                  widget.trip.editEvent(oldEvent, editController.text);
                });
                Navigator.of(context).pop();
                _saveTrips();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
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
      _saveTrips();
    }
  }

  Future<void> _saveTrips() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> encodedData = [widget.trip.toJson()];
    await prefs.setString('trips', jsonEncode(encodedData));
  }
}

