import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/service/world_list.dart';



class ChooseLocation extends StatefulWidget {
  //const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  final WorldList worldList = WorldList();

  void handleTimezoneTap(WorldList timezone) async {

    Navigator.pushReplacementNamed(context, '/', arguments: {
      'location' : timezone.location,
      'country' : timezone.location,
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text('Choose Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<List<WorldList>>(
        future: worldList.fetchTimezones(), // Fetch the list of timezones
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Display a loading indicator while fetching data
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No data available');
          } else {
            // Display the fetched timezones in a ListView
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final timezone = snapshot.data![index];
                return ListTile(
                  title: Text(timezone.location ?? ''),
                  //subtitle: Text('${timezone.area ?? ''}, ${timezone.region ?? ''}'),
                  onTap: () {
                    // Handle onTap action, when tap. it will need to pass data to loading page
                    handleTimezoneTap(timezone);
                    print(timezone.location);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}