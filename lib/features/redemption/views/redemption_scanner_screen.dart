import 'package:clinics/core/widgets/gradient_background.dart';
import 'package:clinics/features/redemption/cubit/redemption_cubit.dart';
import 'package:clinics/features/redemption/cubit/redemption_state.dart';
import 'package:clinics/features/redemption/views/redemption_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class RedemptionScannerScreen extends StatefulWidget {
  const RedemptionScannerScreen({super.key});

  @override
  State<RedemptionScannerScreen> createState() =>
      _RedemptionScannerScreenState();
}

class _RedemptionScannerScreenState extends State<RedemptionScannerScreen> {
  final RedemptionCubit _redemptionCubit = GetIt.instance<RedemptionCubit>();
  bool _isScanning = true;
  String? _scannedCode;

  @override
  void dispose() {
    _redemptionCubit.close();
    super.dispose();
  }

  void _onQRCodeDetected(BarcodeCapture capture) {
    if (!_isScanning) return;

    final code = capture.barcodes.first.rawValue;
    if (code != null && code.isNotEmpty) {
      setState(() {
        _isScanning = false;
        _scannedCode = code;
      });

      // Verify the redemption code
      _redemptionCubit.verifyRedemptionCode(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _redemptionCubit,
      child: BlocListener<RedemptionCubit, RedemptionState>(
        listener: (context, state) {
          state.maybeWhen(
            success: (data) {
              // Navigate to result screen when verification is successful
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: _redemptionCubit,
                    child: const RedemptionResultScreen(),
                  ),
                ),
              ).then((_) {
                // Reset state when returning from result screen
                _redemptionCubit.reset();
                setState(() {
                  _isScanning = true;
                  _scannedCode = null;
                });
              });
            },
            error: (message) {
              // Navigate to result screen when verification fails
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: _redemptionCubit,
                    child: const RedemptionResultScreen(),
                  ),
                ),
              ).then((_) {
                // Reset state when returning from result screen
                _redemptionCubit.reset();
                setState(() {
                  _isScanning = true;
                  _scannedCode = null;
                });
              });
            },
            orElse: () {},
          );
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Scan Redemption Code',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
          ),
          body: GradientBackground(
            child: Stack(
              children: [
                MobileScanner(
                  onDetect: _onQRCodeDetected,
                ),
                // Custom overlay
                Positioned.fill(
                  child: CustomPaint(
                    painter: _QRScannerOverlayPainter(),
                  ),
                ),
                if (!_isScanning)
                  Container(
                    color: Colors.black54,
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ),
                // Instructions at bottom
                Positioned(
                  bottom: 24,
                  left: 24,
                  right: 24,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.qr_code_scanner,
                          size: 48,
                          color: Colors.white,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Point the camera at the QR code',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'The code will be scanned automatically',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                if (_scannedCode != null)
                  Positioned(
                    top: 80,
                    left: 24,
                    right: 24,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.blue.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.qr_code,
                            color: Colors.blue,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Scanned: $_scannedCode',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QRScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    const cutOutSize = 250.0;

    final cutOutRect = Rect.fromCenter(
      center: center,
      width: cutOutSize,
      height: cutOutSize,
    );

    // Draw dimmed background with cutout
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRect(cutOutRect)
      ..fillType = PathFillType.evenOdd;
    canvas.drawPath(path, paint);

    // Draw border around cutout
    final borderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    canvas.drawRect(cutOutRect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
