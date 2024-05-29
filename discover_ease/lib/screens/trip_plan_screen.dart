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
        title: Text('Trip Planner',
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
            ),
            Expanded(
              child: ListView.builder(
                itemCount: trips.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(trips[index].name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _editTripName(context, trips[index]);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
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
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  trip.name = editController.text;
                });
                Navigator.of(context).pop();
              },
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
            children: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: Text(selectedDate == null
                          ? 'Select Date'
                          : DateFormat('yMd').format(selectedDate!)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextField(
                controller: participantController,
                decoration: InputDecoration(
                  labelText: 'Add Participant',
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.trip.addParticipant(participantController.text);
                    participantController.clear();
                  });
                },
                child: Text('Add Participant'),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.trip.participants.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.trip.participants[index], style: TextStyle(fontWeight: FontWeight.normal)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _editParticipant(context, widget.trip.participants[index]);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              widget.trip.removeParticipant(widget.trip.participants[index]);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              TextField(
                controller: placeController,
                decoration: InputDecoration(
                  labelText: 'Add Place',
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.trip.addPlace(placeController.text);
                    placeController.clear();
                  });
                },
                child: Text('Add Place'),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.trip.places.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.trip.places[index], style: TextStyle(fontWeight: FontWeight.normal)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _editPlace(context, widget.trip.places[index]);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              widget.trip.removePlace(widget.trip.places[index]);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              TextField(
                controller: eventController,
                decoration: InputDecoration(
                  labelText: 'Add Event',
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.trip.addEvent(eventController.text);
                    eventController.clear();
                  });
                },
                child: Text('Add Event'),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.trip.events.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.trip.events[index], style: TextStyle(fontWeight: FontWeight.normal)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _editEvent(context, widget.trip.events[index]);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              widget.trip.removeEvent(widget.trip.events[index]);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
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
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  widget.trip.editParticipant(participant, editController.text);
                });
                Navigator.of(context).pop();
              },
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
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  widget.trip.editPlace(place, editController.text);
                });
                Navigator.of(context).pop();
              },
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
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  widget.trip.editEvent(event, editController.text);
                });
                Navigator.of(context).pop();
              },
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
