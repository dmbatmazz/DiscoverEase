class User {
  String username;
  String email;
  String password;
  String phoneNumber;
  DateTime dateOfBirth;
  String preferences;
  List<String> interests;
  List<Activity> savedActivities;
  List<Activity> pastActivities;
  List<Location> savedLocations;
  List<Location> bookedLocations;
  List<Tour> savedTours;
  List<Tour> enrolledTours;
  //List<Favorite> favorites;

  // Constructor
  User({
    required this.username,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.preferences,
    required this.interests,
    required this.savedActivities,
    required this.pastActivities,
    required this.savedLocations,
    required this.bookedLocations,
    required this.savedTours,
    required this.enrolledTours,
    //required this.favorites,
  });
/*User user = User(
  username: 'john_doe',
  email: 'john@example.com',
  password: 'password123',
  phoneNumber: '1234567890',
  dateOfBirth: DateTime(1990, 5, 20),
  preferences: 'Some preferences',
  interests: ['Interest 1', 'Interest 2'],
  savedActivities: [],
  pastActivities: [],
  savedLocations: [],
  bookedLocations: [],
  savedTours: [],
  enrolledTours: [],
  favorites: [],
);*/

  // Methods
  void login() {
    // Code for login
  }

  void logout() {
    // Code for logout
  }

  void updateProfile() {
    // Code for updating profile
  }

  void addInterest(String interest) {
    interests.add(interest);
  }

  void removeInterest(String interest) {
    interests.remove(interest);
  }

  void saveActivity(Activity activity) {
    savedActivities.add(activity);
  }

  void removeSavedActivity(Activity activity) {
    savedActivities.remove(activity);
  }

  void attendActivity(Activity activity) {
    // Code for attending activity
  }

  void optOutActivity(Activity activity) {
    // Code for opting out of activity
  }

  void saveLocation(Location location) {
    savedLocations.add(location);
  }

  void removeSavedLocation(Location location) {
    savedLocations.remove(location);
  }

  void bookLocation(Location location) {
    bookedLocations.add(location);
  }

  void cancelLocation(Location location) {
    bookedLocations.remove(location);
  }

  void saveTour(Tour tour) {
    savedTours.add(tour);
  }

  void removeSavedTour(Tour tour) {
    savedTours.remove(tour);
  }

  void enrollTour(Tour tour) {
    enrolledTours.add(tour);
  }

  void withdrawTour(Tour tour) {
    enrolledTours.remove(tour);
  }
}

class Activity {
  String activityName;
  List<String> activityTags;
  String activityDescription;
  Location location;
  DateTime startTime;
  DateTime endTime;
  List<User> participants;
  int maxParticipants;
  double price;
  Duration duration;
  User organizer;

  // Constructor
  Activity({
    required this.activityName,
    required this.activityTags,
    required this.activityDescription,
    required this.location,
    required this.startTime,
    required this.endTime,
    required this.participants,
    required this.maxParticipants,
    required this.price,
    required this.duration,
    required this.organizer,
  });


  String getActivityName() => activityName;
  void setActivityName(String name) {
    activityName = name;
  }

  List<String> getActivityTags() => activityTags;
  void addActivityTag(String tag) {
    activityTags.add(tag);
  }
  void removeActivityTag(String tag) {
    activityTags.remove(tag);
  }

  String getActivityDescription() => activityDescription;
  void setActivityDescription(String description) {
    activityDescription = description;
  }

  Location getLocation() => location;
  void setLocation(Location newLocation) {
    location = newLocation;
  }

  DateTime getStartTime() => startTime;
  void setStartTime(DateTime newStartTime) {
    startTime = newStartTime;
  }

  DateTime getEndTime() => endTime;
  void setEndTime(DateTime newEndTime) {
    endTime = newEndTime;
  }

  List<User> getParticipants() => participants;
  void addParticipant(User participant) {
    participants.add(participant);
  }
  void removeParticipant(User participant) {
    participants.remove(participant);
  }

  int getMaxParticipants() => maxParticipants;
  void setMaxParticipants(int newMaxParticipants) {
    maxParticipants = newMaxParticipants;
  }

  double getPrice() => price;
  void setPrice(double newPrice) {
    price = newPrice;
  }

  Duration getDuration() => duration;
  void setDuration(Duration newDuration) {
    duration = newDuration;
  }

  User getOrganizer() => organizer;
  void setOrganizer(User newOrganizer) {
    organizer = newOrganizer;
  }
}

class Location {
  String locationName;
  String locationType;
  double latitude;
  double longitude;
  String address;
  String description;
  String openingHours;
  String contactInfo;
  double rating;
  List<String> images;

  // Constructor
  Location({
    required this.locationName,
    required this.locationType,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.description,
    required this.openingHours,
    required this.contactInfo,
    required this.rating,
    required this.images,
  });

  void setLocationName(String name) {
    locationName = name;
  }

  String getLocationName() => locationName;

  void setLocationType(String type) {
    locationType = type;
  }
  String getLocationType() => locationType;

  void setLatitude(double lat) {
    latitude = lat;
  }
  double getLatitude() => latitude;

  void setLongitude(double lon) {
    longitude = lon;
  }
  double getLongitude() => longitude;

  void setAddress(String addr) {
    address = addr;
  }
  String getAddress() => address;

  void setDescription(String desc) {
    description = desc;
  }
  String getDescription() => description;

  void setOpeningHours(String hours) {
    openingHours = hours;
  }
  String getOpeningHours() => openingHours;

  void setContactInfo(String info) {
    contactInfo = info;
  }
  String getContactInfo() => contactInfo;

  void setRating(double rate) {
    rating = rate;
  }
  double getRating() => rating;

  void addImage(String imageURL) {
    images.add(imageURL);
  }
  List<String> getImages() => images;
}

class Tour {
  String tourName;
  List<String> tourLabels;
  String tourDescription;
  List<Location> locations;
  List<Activity> activities;
  DateTime startTime;
  DateTime endTime;
  User organizer;
  List<User> participants;
  int maxParticipants;
  double price;

  // Constructor
  Tour({
    required this.tourName,
    required this.tourLabels,
    required this.tourDescription,
    required this.locations,
    required this.activities,
    required this.startTime,
    required this.endTime,
    required this.organizer,
    required this.participants,
    required this.maxParticipants,
    required this.price,
  });

  String getTourName() => tourName;
  void setTourName(String name) {
    tourName = name;
  }

  List<String> getTourLabels() => tourLabels;
  void addTourLabel(String label) {
    tourLabels.add(label);
  }
  void removeTourLabel(String label) {
    tourLabels.remove(label);
  }

  String getTourDescription() => tourDescription;
  void setTourDescription(String description) {
    tourDescription = description;
  }

  List<Location> getLocations() => locations;
  void addLocation(Location location) {
    locations.add(location);
  }
  void removeLocation(Location location) {
    locations.remove(location);
  }

  List<Activity> getActivities() => activities;
  void addActivity(Activity activity) {
    activities.add(activity);
  }
  void removeActivity(Activity activity) {
    activities.remove(activity);
  }

  DateTime getStartTime() => startTime;
  void setStartTime(DateTime newStartTime) {
    startTime = newStartTime;
  }

  DateTime getEndTime() => endTime;
  void setEndTime(DateTime newEndTime) {
    endTime = newEndTime;
  }

  User getOrganizer() => organizer;
  void setOrganizer(User newOrganizer) {
    organizer = newOrganizer;
  }

  List<User> getParticipants() => participants;
  void addParticipant(User participant) {
    participants.add(participant);
  }
  void removeParticipant(User participant) {
    participants.remove(participant);
  }

  int getMaxParticipants() => maxParticipants;
  void setMaxParticipants(int newMaxParticipants) {
    maxParticipants = newMaxParticipants;
  }

  double getPrice() => price;
  void setPrice(double newPrice) {
    price = newPrice;
  }
}

class Notification {
  String notificationId;
  String userId;
  String message;
  DateTime timestamp;

  // Constructor
  Notification({
    required this.notificationId,
    required this.userId,
    required this.message,
    required this.timestamp,
  });

  String getNotificationId() => notificationId;
  void setNotificationId(String id) {
    notificationId = id;
  }

  String getUserId() => userId;
  void setUserId(String id) {
    userId = id;
  }

  String getMessage() => message;
  void setMessage(String msg) {
    message = msg;
  }

  DateTime getTimestamp() => timestamp;
  void setTimestamp(DateTime time) {
    timestamp = time;
  }
}

class Event {
  String eventId;
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;
  Location location;
  User organizer;
  List<User> participants;

  // Constructor
  Event({
    required this.eventId,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.organizer,
    required this.participants,
  });

  // Getter and setter for eventId
  String getEventId() => eventId;
  void setEventId(String id) {
    eventId = id;
  }

  // Getter and setter for title
  String getTitle() => title;
  void setTitle(String t) {
    title = t;
  }

  String getDescription() => description;
  void setDescription(String desc) {
    description = desc;
  }

  DateTime getStartDate() => startDate;
  void setStartDate(DateTime date) {
    startDate = date;
  }

  DateTime getEndDate() => endDate;
  void setEndDate(DateTime date) {
    endDate = date;
  }

  Location getLocation() => location;
  void setLocation(Location loc) {
    location = loc;
  }

  User getOrganizer() => organizer;
  void setOrganizer(User org) {
    organizer = org;
  }

  List<User> getParticipants() => participants;
  
  void addParticipant(User participant) {
    participants.add(participant);
  }
  
  void removeParticipant(User participant) {
    participants.remove(participant);
  }
}

class Favorite {
  //TODO I DONT FUCKING KNOW WHAT TO PUT HERE
}
