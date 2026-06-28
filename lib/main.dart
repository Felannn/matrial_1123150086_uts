import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';
import 'package:matrial_1123150086_uts/core/constants/app_strings.dart';
import 'package:matrial_1123150086_uts/core/constants/app_constants.dart';
import 'package:matrial_1123150086_uts/core/routes/app_router.dart';
import 'package:matrial_1123150086_uts/core/services/secure_storage.dart';
import 'package:matrial_1123150086_uts/core/services/dio_client.dart';
import 'package:matrial_1123150086_uts/core/theme/app_theme.dart';
import 'package:matrial_1123150086_uts/features/auth/presentation/providers/auth_provider.dart';
import 'package:matrial_1123150086_uts/features/cart/presentation/providers/cart_provider.dart';
import 'package:matrial_1123150086_uts/features/cart/presentation/providers/checkout_provider.dart';
import 'package:matrial_1123150086_uts/features/cart/presentation/pages/payment_success_page.dart';
import 'package:matrial_1123150086_uts/features/dashboard/presentation/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:matrial_1123150086_uts/core/services/notification_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationService().init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => CheckoutProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appLinks = AppLinks();
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _initDeepLinkListener();
  }

  void _initDeepLinkListener() {
    _appLinks.uriLinkStream.listen((uri) {
      debugPrint('[TokoMaterial] Deep link masuk: $uri');
      if (uri.scheme == 'tokomaterial' && uri.host == 'callback') {
        _handleCallback(uri);
      }
    });
  }

  Future<void> _handleCallback(Uri uri) async {
    final status = uri.queryParameters['status'];
    final reference = uri.queryParameters['reference'];

    debugPrint('[TokoMaterial] Callback status: $status, reference: $reference');

    if (reference == null || reference.isEmpty) return;

    if (status == 'success') {
      try {
        final response = await DioClient.instance.get(
          '${AppConstants.baseUrl}/transactions/callback?status=success&reference=$reference',
        );
        debugPrint('[TokoMaterial] Callback backend response: ${response.statusCode}');
      } catch (e) {
        debugPrint('[TokoMaterial] Gagal update status ke backend: $e');
      }

      _navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => PaymentSuccessPage(
            onSuccess: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ),
        (route) => route.isFirst,
      );
    } else {
      final message = status == 'cancelled'
          ? 'Pembayaran dibatalkan.'
          : 'Pembayaran gagal. Silakan coba lagi.';
      
      final context = _navigatorKey.currentContext;
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey:           _navigatorKey,
      title:                  AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme:                  AppTheme.light,
      initialRoute:           AppRouter.login,
      routes:                 AppRouter.routes,
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 2)); // Animasi splash
    if (!mounted) return;

    final token = await SecureStorage.getToken();
    final route = token != null ? AppRouter.dashboard : AppRouter.login;
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(child: CircularProgressIndicator()),
  );
}