
import 'package:app_movie/app_container.dart';
import 'package:app_movie/bloc/location.dart';
import 'package:app_movie/screens/completed/completed_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearMeScreen extends StatefulWidget {
  @override
  _NearMeScreenState createState() => _NearMeScreenState();
}

class _NearMeScreenState extends State<NearMeScreen> with AutomaticKeepAliveClientMixin<NearMeScreen> {

  Future<QuerySnapshot> getLocation() async {
    return await Firestore.instance.collection('locations').getDocuments();
  }

  Future<String> _setStyle() async {
    String data;
    data = await DefaultAssetBundle.of(context)
        .loadString('assets/maps_style.json');
    return data;
  }

  LocationBloc _locationBloc;
  List<Marker> _markers = [];


  @override
  void initState() {
    _locationBloc = LocationBloc();
    _locationBloc.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //ToDo Build release map crash
    return kReleaseMode ? AppContainer(child: Container()):  AppContainer(
        isStatusBar: false,
        hidePadding: true,
        child: FutureBuilder<QuerySnapshot>(
            future: getLocation(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                snapshot.data.documents.forEach((element) {
                  _markers.add(Marker(
                      markerId: MarkerId(element['info']),
                      position: LatLng(element['lat'], element['long'])));
                });
                return GoogleMap(
                    mapToolbarEnabled: true,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    markers: Set<Marker>.of(_markers),
                    onTap: (LatLng latLng) {
                       Navigator.push(context, MaterialPageRoute(builder: (ctx) => CompletedScreen()));
                    },
                    initialCameraPosition: CameraPosition(
                        target:
                            LatLng(10.783861117913025, 106.70188145391356)));
              }
              return Container();
            }));
  }
  @override
  bool get wantKeepAlive => true;
}
