import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';

LocationBloc locationBloc;

typedef LocationCallBack = void Function(bool isCheck);

class LocationBloc {
  final Location _location = Location();
  bool _serviceEnabled;
  PermissionStatus _permissionStatus;
  LocationData _locationData;

  final BehaviorSubject<String> _address = BehaviorSubject<String>();

  Stream<String> get address => _address?.stream;

  Future<void> init() async {
    _getLocation();
  }

  LocationCallBack callBack;

  Future<void> dispose() async {
    _address?.close();
  }

  String location() {
    return _address?.value;
  }

  Future<void> _getLocation() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        callBack(true);
        return;
      }
    }
    _permissionStatus = await _location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await _location.requestPermission();
      if (_permissionStatus != PermissionStatus.granted) {
        callBack(false);
        return;
      }
      _locationData = await _location.getLocation();
      _location.onLocationChanged.listen((LocationData currentLocation) {
        _locationData = currentLocation;
      });
      final Coordinates coordinates =
          Coordinates(_locationData.latitude, _locationData.longitude);
      final List<Address> address =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      _address?.sink?.add(address.first.addressLine);

    } else if (_permissionStatus == PermissionStatus.denied) {
      callBack(false);
    }
  }
}
