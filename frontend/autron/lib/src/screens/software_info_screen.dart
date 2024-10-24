import 'package:autron/src/services/request_service.dart';
import 'package:autron/src/view_models/department_model.dart';
import 'package:autron/src/view_models/request_model.dart';
import 'package:autron/src/view_models/software_model.dart';
import 'package:flutter/material.dart';
import 'package:autron/src/widgets/app_bar.dart';
import 'package:autron/src/widgets/request_access_form.dart';

/// The SoftwareInfoPage widget displays the information of a software.
///
/// The software information page displays the software name and status, and allows the user to request access to the software.
class SoftwareInfoPage extends StatefulWidget {
  final int softwareId;
  final String softwareName;
  final String? softwareStatus;
  final String? softwareInfo =
      'This is a placeholder for software information.';

  const SoftwareInfoPage({
    super.key,
    required this.id,
    required this.name,
    required this.image,
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
          id: widget.id,
          name: widget.name,
          image: widget.image,
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
        appBar: CustomAppBar(title: '$softwareName Information'),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                softwareName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Text(
              //   softwareInfo,
              //   style: const TextStyle(fontSize: 16),
              // ),
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
                      text: softwareStatus,
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
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RequestAccessForm(
                        softwareName:
                            softwareName, // Pass the software name to the request form
                      ),
                    ),
                  );
                },
                child: const Text('Request Access'),
              )
            ],
          ),
        ));
  }
}
