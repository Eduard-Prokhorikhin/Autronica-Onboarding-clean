import 'package:autron/src/services/request_service.dart';
import 'package:autron/src/view_models/department_model.dart';
import 'package:autron/src/view_models/request_model.dart';
import 'package:autron/src/view_models/software_model.dart';
import 'package:flutter/material.dart';
import 'package:autron/src/widgets/app_bar.dart';

class SoftwareInfoPage extends StatefulWidget {
  final int softwareId;
  final String softwareName;
  final Department department;

  const SoftwareInfoPage({
    super.key,
    required this.softwareId,
    required this.softwareName,
    required this.department,
  });

  @override
  _SoftwareInfoPageState createState() => _SoftwareInfoPageState();
}

class _SoftwareInfoPageState extends State<SoftwareInfoPage> {
  bool _isLoading = false;
  String? _errorMessage;
  String _requestStatus = 'Not Requested';

  Future<void> _requestSoftwareAccess() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final request = Request(
      id: 1,
      status: 'pending',
      software: Software(
          id: widget.softwareId,
          name: widget.softwareName,
          department: widget.department),
    );

    try {
      await RequestService().requestSoftware(request);
      setState(() {
        _requestStatus = 'Requested';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to request access: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '$widget.softwareName Information'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.softwareName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Status: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text: _requestStatus,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (_errorMessage != null) // Display error message if there is one
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _requestSoftwareAccess,
              child: _isLoading
                  ? const CircularProgressIndicator() // Show loading indicator
                  : const Text('Request Access'),
            ),
          ],
        ),
      ),
    );
  }
}
