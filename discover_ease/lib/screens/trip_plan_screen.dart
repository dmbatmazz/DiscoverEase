import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trip Planner',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: tripNameController,
              decoration: InputDecoration(
                labelText: 'Trip Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (tripNameController.text.isNotEmpty) {
                  setState(() {
                    trips.add(Trip(name: tripNameController.text, date: DateTime.now()));
                    tripNameController.clear();
                  });
                }
              },
              child: Text('Add Trip'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: trips.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(trips[index].name, style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(DateFormat('yMMMd').format(trips[index].date)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blueAccent),
                            onPressed: () {
                              _editTripName(context, trips[index]);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () {
                              setState(() {
                                trips.removeAt(index);
                              });
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
                setState(() {
                  trip.name = editController.text;
                });
                Navigator.of(context).pop();
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
}

class Trip {
  String name;
  DateTime date;
  List<String> participants = [];
  List<String> places = [];
  List<String> events = [];

  Trip({required this.name, required this.date});

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
                  backgroundColor: Colors.blueAccent,
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
                  labelText: 'Add Participant',
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
                  }
                },
                child: Text('Add Participant'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
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
                  onDelete: () => setState(() {
                    widget.trip.removeParticipant(participant);
                  }),
                );
              }),
              SizedBox(height: 16),
              _buildSectionTitle('Places'),
              TextField(
                controller: placeController,
                decoration: InputDecoration(
                  labelText: 'Add Place',
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
                  }
                },
                child: Text('Add Place'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
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
                  onDelete: () => setState(() {
                    widget.trip.removePlace(place);
                  }),
                );
              }),
              SizedBox(height: 16),
              _buildSectionTitle('Events'),
              TextField(
                controller: eventController,
                decoration: InputDecoration(
                  labelText: 'Add Event',
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
                  }
                },
                child: Text('Add Event'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
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
                  onDelete: () => setState(() {
                    widget.trip.removeEvent(event);
                  }),
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
          color: Colors.blueAccent,
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
              icon: Icon(Icons.edit, color: Colors.blueAccent),
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

  Future<void> _editParticipant(BuildContext context, String participant) async {
    final TextEditingController editController = TextEditingController(text: participant);

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
                  widget.trip.editParticipant(participant, editController.text);
                });
                Navigator.of(context).pop();
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

  Future<void> _editPlace(BuildContext context, String place) async {
    final TextEditingController editController = TextEditingController(text: place);

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
                  widget.trip.editPlace(place, editController.text);
                });
                Navigator.of(context).pop();
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

  Future<void> _editEvent(BuildContext context, String event) async {
    final TextEditingController editController = TextEditingController(text: event);

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
                  widget.trip.editEvent(event, editController.text);
                });
                Navigator.of(context).pop();
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
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.trip.date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.trip.date = picked; // Trip nesnesinin tarihini güncelle
      });
    }
  }
}
