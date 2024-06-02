import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Home",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        actions: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: Color.fromARGB(255, 42, 140, 122),
                size: 20,
              ),
              SizedBox(width: 5),
              Text(
                'Ankara',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 16),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 42, 140, 122),
                    ),
                    child: Text(
                      'Most Visited',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 42, 140, 122),
                    ),
                    child: Text(
                      'Things to Do',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 42, 140, 122),
                    ),
                    child: Text(
                      'Food & Drink',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => placeCard(index),
              ),
            ),
          ],
        ),
      ),
    );
  }

 Widget placeCard(int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/city/city${index + 1}.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.8), BlendMode.dstATop),
                ),
              ),
              width: double.infinity,
              height: 150,
              child: Stack(
                children: [
                  // Ortadan çapraz şekilde siyah saydam alan
                  Positioned(
                    left: 160,
                    top: 0,
                    bottom: 0,
                    child: Transform.rotate(
                      angle: -0.785398, // -45 derece döndürme
                      child: Container(
                        width: 400,
                        color:
                            Colors.black.withOpacity(0.5), // Saydam siyah renk
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Stack(
                          children: [
                            // Kenar yazısı (siyah stroke)
                            Text(
                              'Place Name',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 2
                                  ..color = Colors.black,
                              ),
                            ),
                            // Ana yazı (beyaz)
                            Text(
                              'Place Name',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 248, 248),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.star, color: Colors.yellow, size: 20),
                            SizedBox(width: 5),
                            Text(
                              '4.5',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}