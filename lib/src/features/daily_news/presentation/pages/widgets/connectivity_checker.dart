import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../../../core/utils/helpers/connectivity_service.dart';

class ConnectivityChecker extends StatefulWidget {
  ConnectivityChecker({super.key, required this.child});
  final Widget child;

  @override
  _ConnectivityCheckerState createState() => _ConnectivityCheckerState();
}

class _ConnectivityCheckerState extends State<ConnectivityChecker> {
  late ConnectivityService _connectivityService;
  late Stream<List<ConnectivityResult>> _connectivityStream;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _connectivityService = ConnectivityService();
    _connectivityStream = _connectivityService.connectivityStream;
    _checkInitialConnection();
  }

  Future<void> _checkInitialConnection() async {
    _isConnected = await _connectivityService.isConnected();
    if (!_isConnected) {
      _showNoConnectionDialog();
    }
  }

  void _showNoConnectionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text('No Internet Connection'),
        content: Text('Please enable internet connection to continue.'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              _isConnected = await _connectivityService.isConnected();
              if (!_isConnected) {
                _showNoConnectionDialog();
              }
            },
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ConnectivityResult>>(
      stream: _connectivityStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final result = snapshot.data;
          _isConnected = result!.contains(ConnectivityResult.none);
        }
        if (!_isConnected) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showNoConnectionDialog();
          });
        }
        return widget.child;
      },
    );
  }
}
