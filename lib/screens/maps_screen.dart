import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../services/geolocator_service.dart';

import '../blocks/application_block.dart';

class MapsScreen extends StatefulWidget {
  late LocationPermission _permission;

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  @override
  void initState() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    

    return Scaffold(
      body: (applicationBloc.currentLocation == null )
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Location',
                    suffixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) => applicationBloc.searchPlaces(value),
                ),
              ),
              Stack(
                children: [
                  Container(
                    height: 630.0,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(applicationBloc.currentLocation.latitude,
                            applicationBloc.currentLocation.longitude),
                        zoom: 14,
                      ),
                      myLocationEnabled: true,
                    ),
                  ),
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.2),
                      backgroundBlendMode: BlendMode.darken,
                    ),
                  ),
                  Container(
                    height: 300,
                    child: ListView.builder(
                      itemCount: applicationBloc.searchResults.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            applicationBloc.searchResults[index].description,
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ]),
    );
  }
}
