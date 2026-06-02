import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:navithera_client/core/routes/app_router.dart';
import 'package:navithera_client/core/theme/app_colors.dart';
import 'package:navithera_client/core/notification/file_upload_service.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:navithera_client/core/constants/base_url.dart';
import 'package:navithera_client/feature/questionnaire/domain/entities/preference_models.dart';
import 'package:navithera_client/feature/questionnaire/presentation/providers/extra_questions_provider.dart';
import 'package:navithera_client/feature/questionnaire/presentation/providers/questions_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';

class FileUploadService {
  // Upload a single payment document and return backend filename (String)
  static const _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );
  static Future<String> uploadPaymentDocument(
    File file, {
    String? subscriptionId,
  }) async {
    final accessToken = await _secureStorage.read(key: 'access_token');

    if (accessToken == null) {
      throw Exception('No access token found. Please login again.');
    }

    // Build URL with subscriptionId as query parameter (not form field)
    Uri uri;
    if (subscriptionId != null && subscriptionId.isNotEmpty) {
      uri = Uri.parse(
        '${base_url_dev}/client/me/upload/payment?subscriptionId=$subscriptionId',
      );
    } else {
      uri = Uri.parse('${base_url_dev}/client/me/upload/payment');
    }

    final request = http.MultipartRequest('POST', uri);

    request.headers['Authorization'] = 'Bearer $accessToken';
    request.headers['accept'] = 'application/json'; // Add accept header

    // Determine MIME type
    final extension = file.path.split('.').last.toLowerCase();
    String mimeType;
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        mimeType = 'image/jpeg';
        break;
      case 'png':
        mimeType = 'image/png';
        break;
      case 'gif':
        mimeType = 'image/gif';
        break;
      case 'pdf':
        mimeType = 'application/pdf';
        break;
      case 'doc':
        mimeType = 'application/msword';
        break;
      case 'docx':
        mimeType =
            'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
        break;
      default:
        mimeType = 'application/octet-stream';
    }

    request.files.add(
      await http.MultipartFile.fromPath(
        'file', // This matches the curl command's '-F file=@...'
        file.path,
        contentType: MediaType.parse(mimeType),
      ),
    );

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw Exception(
          'Failed to upload file: ${response.statusCode} ${response.body}',
        );
      }

      final responseData = json.decode(response.body);

      // Adjust this based on your API response structure
      final filename =
          responseData['data']?['filename'] ?? responseData['filename'];
      if (filename is! String || filename.isEmpty) {
        throw Exception('Upload succeeded but no filename returned.');
      }
      return filename;
    } catch (e) {
      throw Exception('Error uploading file: $e');
    }
  }

  // Static method to submit payment
  static Future<Map<String, dynamic>> submitPayment({
    required String subscriptionId,
    required double amount,
    required String filename,
    String? receiptUrl,
    String method = 'bank_transfer',
  }) async {
    final accessToken = await _secureStorage.read(key: 'access_token');

    if (accessToken == null) {
      throw Exception('No access token found. Please login again.');
    }

    final uri = Uri.parse('${base_url_dev}/payment');

    // Get current date in ISO 8601 format
    final now = DateTime.now().toUtc();
    final date = now.toIso8601String();

    final payload = {
      'subscriptionId': subscriptionId,
      'amount': amount,
      'date': date,
      'method': method,
      'filename': filename,
      if (receiptUrl != null && receiptUrl.isNotEmpty) 'receipt': receiptUrl,
    };

    try {
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
          'accept': 'application/json',
        },
        body: json.encode(payload),
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw Exception(
          'Failed to submit payment: ${response.statusCode} ${response.body}',
        );
      }

      final responseData = json.decode(response.body);
      return responseData;
    } catch (e) {
      throw Exception('Error submitting payment: $e');
    }
  }
}

// ... (import statements remain the same)

class PaymentUploadPage extends ConsumerStatefulWidget {
  final String sessionId;
  final String preferenceId; // Changed from optional to required

  const PaymentUploadPage({
    Key? key,
    required this.sessionId,
    required this.preferenceId, // Now required
  }) : super(key: key);

  @override
  ConsumerState<PaymentUploadPage> createState() => _PaymentUploadPageState();
}

class _PaymentUploadPageState extends ConsumerState<PaymentUploadPage> {
  //final _amountController = TextEditingController();
  final _receiptController = TextEditingController();
  final _filenameController = TextEditingController(); // read-only display

  //bool _isAmountValid = true;
  //String _amountError = '';

  bool _isReceiptValid = true; // optional; only validates if not empty
  String _receiptError = '';

  // Picking/uploading states
  bool _hasLocalFile = false; // has user selected a local file
  String? _fileExt; // pdf, jpg, etc., inferred from local filename
  bool _isPicking = false; // selecting via file picker
  bool _isUploading = false; // uploading to server
  bool _isSubmitting = false; // submitting payment

  // Uploaded filename returned by backend (to submit later)
  String? _uploadedFilename;

  // Currency input filter: allows numbers and one dot with max 2 decimals
  final _amountFormatter = [
    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
  ];

  @override
  void dispose() {
    // _amountController.dispose();
    _receiptController.dispose();
    _filenameController.dispose();
    super.dispose();
  }

  // void _validateAmount(String value) {
  //   setState(() {
  //     if (value.trim().isEmpty) {
  //       _isAmountValid = false;
  //       _amountError = 'Amount is required';
  //       return;
  //     }
  //     final num? parsed = num.tryParse(value);
  //     if (parsed == null) {
  //       _isAmountValid = false;
  //       _amountError = 'Enter a valid number';
  //       return;
  //     }
  //     if (parsed <= 0) {
  //       _isAmountValid = false;
  //       _amountError = 'Amount must be greater than 0';
  //       return;
  //     }
  //     _isAmountValid = true;
  //     _amountError = '';
  //   });
  // }

  void _validateReceipt(String value) {
    if (value.trim().isEmpty) {
      setState(() {
        _isReceiptValid = true;
        _receiptError = '';
      });
      return;
    }
    final uri = Uri.tryParse(value.trim());
    final looksUrl = uri != null && (uri.hasScheme && uri.host.isNotEmpty);
    setState(() {
      _isReceiptValid = looksUrl;
      _receiptError = looksUrl ? '' : 'Enter a valid URL (e.g. https://...)';
    });
  }

  String _inferExt(String name) {
    final idx = name.lastIndexOf('.');
    if (idx == -1) return 'file';
    return name.substring(idx + 1).toLowerCase();
  }

  Future<void> _pickAndUploadFile() async {
    if (_isPicking || _isUploading) return;

    setState(() {
      _isPicking = true;
    });

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        withReadStream: false,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'webp'],
      );

      if (result == null || result.files.isEmpty) {
        // User canceled
        setState(() {
          _isPicking = false;
        });
        return;
      }

      final picked = result.files.first;

      // Optional: enforce size limit (e.g., 10MB)
      const maxBytes = 10 * 1024 * 1024;
      if (picked.size != null && picked.size > maxBytes) {
        setState(() {
          _isPicking = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('File too large. Max 10MB.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final path = picked.path;
      if (path == null) {
        setState(() {
          _isPicking = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not read the selected file path.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final file = File(path);
      final localName = picked.name;
      final ext = _inferExt(localName);

      // Update local UI to show selected file while we upload
      setState(() {
        _filenameController.text = localName;
        _fileExt = ext;
        _hasLocalFile = true;
        _uploadedFilename = null; // reset previous upload
        _isPicking = false;
        _isUploading = true;
      });

      // Upload to backend
      final uploadedName = await FileUploadService.uploadPaymentDocument(
        file,
        subscriptionId:
            widget.sessionId, // Pass the sessionId as subscriptionId
      );

      setState(() {
        _uploadedFilename = uploadedName;
        _isUploading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('File uploaded successfully.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      String errorMessage = 'Failed to upload file. Please try again.';
      if (e is DioException && e.response != null) {
        // ignore: avoid_print
        print('Server responded with status code: ${e.response?.statusCode}');
        // ignore: avoid_print
        print('Response data: ${e.response?.data}');

        final responseData = e.response?.data;
        String errorMessage = 'Failed to upload';

        if (responseData is Map) {
          errorMessage =
              responseData['message'] ??
              responseData['error'] ??
              'Failed to submit session selection';
        } else if (responseData is String) {
          try {
            final parsed = json.decode(responseData);
            errorMessage = parsed['message'] ?? errorMessage;
          } catch (_) {
            errorMessage = responseData;
          }
        }

        // return {'success': false, 'message': errorMessage};
      } else {
        // ignore: avoid_print
        print('Error submitting');
        // return {'success': false, 'message': 'Network error: ${e.toString()}'};
      }
      setState(() {
        _isPicking = false;
        _isUploading = false;
        _hasLocalFile = false;
        _filenameController.clear();
        _fileExt = null;
        _uploadedFilename = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
    }
  }

  void _clearFile() {
    if (_isUploading) return; // prevent while uploading
    setState(() {
      _filenameController.clear();
      _fileExt = null;
      _hasLocalFile = false;
      _uploadedFilename = null;
    });
  }

  bool get _canSubmit {
    // require amount valid, receipt valid, and uploaded filename exists
    return _isReceiptValid &&
        (_uploadedFilename != null && _uploadedFilename!.isNotEmpty);
  }

  Future<void> _onSubmit() async {
    final router = ref.watch(routerProvider);
    if (!_canSubmit || _isSubmitting) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      // final amount = double.parse(_amountController.text.trim());
      final receiptUrl =
          _receiptController.text.trim().isEmpty
              ? null
              : _receiptController.text.trim();
      final uploadedFilename = _uploadedFilename!;

      // Call the payment submission API
      final response = await FileUploadService.submitPayment(
        subscriptionId: widget.sessionId,
        amount: 455,
        filename: uploadedFilename,
        receiptUrl: receiptUrl,
        method: 'bank_transfer',
      );

      // Success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payment submitted successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );

      // Use the preferenceId from widget parameter or from riverpod provider
      final modalId = ref.read(modalIdProvider);

      // if (modalId == "aa4c9839-e031-417a-b319-2da4bf1092c3") {
      //   // If modalId matches specific value, go to blocked user screen directly
      //   // router.go('/blocked-user');
      //   print("modalId matched");
      // } else {
      //   print("modalId here");
      // }

      // if (modalId != "aa4c9839-e031-417a-b319-2da4bf1092c3") {
      //   await _handleSubmit(preferenceId);
      // } else {
      //   print("No handle submit called");
      //   // If no preferenceId, just go to blocked user screen
      //   router.go('/blocked-user');
      // }
      if (modalId != "aa4c9839-e031-417a-b319-2da4bf1092c3") {
        await _handleSubmit(widget.preferenceId);
      } else {
        router.go('/blocked-user');
      }
    } catch (e) {
      String errorMessage = 'Failed to Submit. Please try again.';
      if (e is DioException && e.response != null) {
        // ignore: avoid_print
        print('Server responded with status code: ${e.response?.statusCode}');
        // ignore: avoid_print
        print('Response data: ${e.response?.data}');

        final responseData = e.response?.data;
        String errorMessage = 'Failed to upload';

        if (responseData is Map) {
          errorMessage =
              responseData['message'] ??
              responseData['error'] ??
              'Failed to submit';
        } else if (responseData is String) {
          try {
            final parsed = json.decode(responseData);
            errorMessage = parsed['message'] ?? errorMessage;
          } catch (_) {
            errorMessage = responseData;
          }
        }

        // return {'success': false, 'message': errorMessage};
      } else {
        // ignore: avoid_print
        print('Error submitting');
        // return {'success': false, 'message': 'Network error: ${e.toString()}'};
      }
      print("e: ${e}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  Future<void> _handleSubmit(String preferenceId) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final router = ref.read(routerProvider);

    try {
      final repository = ref.read(extraQuestionsRepositoryProvider);

      final matchResult = await repository.createMatch(
        MatchRequest(preferenceId: preferenceId),
      );

      matchResult.fold(
        (failure) {
          router.go('/blocked-user');
        },
        (matchResponse) {
          scaffoldMessenger.showSnackBar(
            SnackBar(
              content: Text(matchResponse.data.message),
              backgroundColor: Colors.green,
            ),
          );
          router.go('/blocked-user');
        },
      );
    } catch (e) {
      String errorMessage = 'Failed to Match. Please try again.';
      if (e is DioException && e.response != null) {
        // ignore: avoid_print

        final responseData = e.response?.data;
        String errorMessage = 'Failed to match';

        if (responseData is Map) {
          errorMessage =
              responseData['message'] ??
              responseData['error'] ??
              'Failed to match';
        } else if (responseData is String) {
          try {
            final parsed = json.decode(responseData);
            errorMessage = parsed['message'] ?? errorMessage;
          } catch (_) {
            errorMessage = responseData;
          }
        }

        // return {'success': false, 'message': errorMessage};
      } else {
        // ignore: avoid_print
        print('Error Match');
        // return {'success': false, 'message': 'Network error: ${e.toString()}'};
      }
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
      router.go('/blocked-user');
    }
  }

  @override
  Widget build(BuildContext context) {
    final secondary = AppColors.secondary; // matches your Sign Up button color
    final muted = const Color(0xFF7B7B7B);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.black87),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
        title: const Text(
          'Payment Upload',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _HeaderCard(),
              const SizedBox(height: 6),

              // After the HeaderCard, add this:
              Container(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                child: Row(
                  children: [
                    Container(
                      height: 46,
                      width: 46,
                      decoration: BoxDecoration(
                        color: secondary.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.receipt_long, color: secondary),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bank Transfer Details',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '1000715792536..NAVITHERA TRADING PLC',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Telebirr: 0998888866',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              _labelWithAsterisk('Upload Receipt File'),
              const SizedBox(height: 10),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        _hasLocalFile
                            ? const Color(0xFFF5F5F5)
                            : const Color(0xFFE0E0E0),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    // Top section: pick button + status
                    Container(
                      height: 54,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 12),
                          Icon(Icons.cloud_upload_outlined, color: muted),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _hasLocalFile ? 'Replace file' : 'Select a file',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: ElevatedButton.icon(
                              onPressed:
                                  (_isPicking || _isUploading)
                                      ? null
                                      : _pickAndUploadFile,
                              icon:
                                  _isPicking || _isUploading
                                      ? const SizedBox(
                                        width: 14,
                                        height: 14,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                      : const Icon(Icons.attach_file, size: 18),
                              label: Text(_hasLocalFile ? 'Change' : 'Browse'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: secondary,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Upload progress strip
                    AnimatedContainer(
                      height: _isUploading ? 3 : 0,
                      duration: const Duration(milliseconds: 200),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: secondary.withOpacity(0.8),
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(0),
                        ),
                      ),
                    ),

                    // Selected file preview
                    if (_hasLocalFile)
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(12),
                          ),
                        ),
                        padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _badgeForExt(_fileExt),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: const Color(0xFFE0E0E0),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.insert_drive_file_outlined,
                                          color: Color(0xFF7B7B7B),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            _filenameController.text,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        IconButton(
                                          tooltip: 'Remove',
                                          onPressed:
                                              (_isUploading)
                                                  ? null
                                                  : _clearFile,
                                          icon: Icon(
                                            Icons.close_rounded,
                                            color:
                                                (_isUploading)
                                                    ? Colors.black26
                                                    : Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    _uploadedFilename == null
                                        ? 'Uploading...'
                                        : '',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          _uploadedFilename == null
                                              ? Colors.orange
                                              : const Color(0xFF2E7D32),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  const Text(
                                    'Accepted: PDF, Images, DOC up to 10MB',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF7B7B7B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (!_hasLocalFile)
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'No file selected',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF7B7B7B),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: (_canSubmit && !_isSubmitting) ? _onSubmit : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondary,
                    disabledBackgroundColor: const Color(0xFFBDBDBD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                  ),
                  child:
                      _isSubmitting
                          ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                          : const Text(
                            'Save Payment',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                ),
              ),

              // const SizedBox(height: 12),
              // Center(
              //   child: Text(
              //     'You can add the receipt URL or upload a file. Filename is required.',
              //     textAlign: TextAlign.center,
              //     style: TextStyle(fontSize: 12, color: muted),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _labelWithAsterisk(String text) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          const TextSpan(
            text: ' *',
            style: TextStyle(
              fontSize: 14,
              color: Colors.red,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _badgeForExt(String? ext) {
    final e = (ext ?? 'file').toUpperCase();
    Color bg = const Color(0xFFE8F0FE);
    Color fg = const Color(0xFF2B2D5A);
    if (e == 'PDF') {
      bg = const Color(0xFFFFEBEE);
      fg = const Color(0xFFD32F2F);
    } else if (['JPG', 'JPEG', 'PNG', 'WEBP'].contains(e)) {
      bg = const Color(0xFFE8F5E9);
      fg = const Color(0xFF2E7D32);
    } else if (['DOC', 'DOCX'].contains(e)) {
      bg = const Color(0xFFE3F2FD);
      fg = const Color(0xFF1565C0);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        e,
        style: TextStyle(color: fg, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final secondary = AppColors.secondary;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Row(
        children: [
          Container(
            height: 46,
            width: 46,

            child: Icon(Icons.receipt_long, color: secondary),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Payment Details',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  'Enter the amount, an optional receipt URL, and upload the receipt file.',
                  style: TextStyle(fontSize: 12.5, color: Color(0xFF7B7B7B)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
