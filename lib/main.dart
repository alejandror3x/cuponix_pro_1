import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/bottom_nav_bar.dart';
import 'screens/welcome/welcome_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/tour/tour_screen.dart';
import 'screens/register/register_screen.dart';
import 'screens/edit_profile/edit_profile_screen.dart';
import 'screens/business_profile/business_profile_screen.dart';
import 'screens/map/map_screen.dart';
import 'screens/product/product_screen.dart';
import 'screens/recover/recover_email_screen.dart';
import 'screens/recover/recover_sent_screen.dart';
import 'screens/recover/recover_user_screen.dart';
import 'screens/recover/verify_code_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/perfil/perfil_screen.dart';
import 'screens/cupones/mis_cupones_screen.dart';
import 'screens/cupones/guardados_screen.dart';
import 'screens/cupones/solicitudes_screen.dart';
import 'screens/cupones/historial_screen.dart';
import 'screens/cupones/crear_cupon_screen.dart';
import 'screens/seguidores/seguidores_screen.dart';
import 'screens/cupon/solicitud_cupon_screen.dart';
import 'screens/cupon/solicitud_canje_screen.dart';
import 'screens/cupon/canjear_puntos_screen.dart';
import 'screens/cupon/mostrar_qr_screen.dart';
import 'screens/cupon/sin_puntos_screen.dart';
import 'screens/cupon/gracias_visitar_screen.dart';
import 'screens/cupon/cupon_listo_screen.dart';
import 'screens/explorar/explorar_screen.dart';
import 'screens/explorar/buscar_resultados_screen.dart';
import 'screens/cupon/usar_cupon_screen.dart';
import 'screens/cupon/mostrar_codigo_screen.dart';
import 'screens/cupon/gracias_cupon_screen.dart';
import 'screens/onboarding/points_help_screen.dart';
import 'screens/onboarding/email_verification_screen.dart';
import 'screens/onboarding/suggested_accounts_screen.dart';
import 'screens/social/business_public_profile_screen.dart';
import 'screens/social/business_followers_screen.dart';
import 'screens/social/messages_screen.dart';
import 'screens/social/chat_screen.dart';
import 'screens/social/business_map_screen.dart';
import 'screens/settings/settings_menu_screen.dart';
import 'screens/settings/edit_account_screen.dart';
import 'screens/settings/edit_profile_settings_screen.dart';
import 'screens/settings/edit_product_screen.dart';
import 'screens/settings/blocked_accounts_screen.dart';
import 'screens/settings/subscription_screen.dart';
import 'screens/settings/permissions_screen.dart';
import 'screens/settings/terms_screen.dart';
import 'screens/settings/help_screen.dart';
import 'screens/utility/qr_scanner_screen.dart';
import 'screens/cupones/historial_detail_screen.dart';
import 'screens/social/product_detail_screen.dart';
import 'screens/states/startup_permissions_screen.dart';
import 'screens/states/empty_state_screen.dart';
import 'screens/states/loading_error_screen.dart';
import 'screens/states/auth_feedback_screen.dart';
import 'screens/states/subscription_status_screen.dart';
import 'screens/states/photo_picker_screen.dart';
import 'screens/states/map_status_screen.dart';

int _tabIndex(String? tab) {
  if (tab == 'menu') return 1;
  if (tab == 'valoraciones') return 2;
  if (tab == 'seguidores') return 1;
  if (tab == 'notificaciones') return 1;
  return 0;
}

final _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, _) => const SplashScreen()),
    GoRoute(path: '/login', builder: (_, _) => const WelcomeScreen()),
    GoRoute(path: '/permisos-inicio', builder: (_, _) => const StartupPermissionsScreen()),
    GoRoute(path: '/tour', builder: (_, _) => const TourScreen()),
    GoRoute(path: '/register', builder: (_, _) => const RegisterScreen()),
    GoRoute(path: '/edit-profile', builder: (_, _) => const EditProfileScreen()),
    GoRoute(path: '/business-profile', builder: (_, _) => const BusinessProfileScreen()),
    GoRoute(path: '/map-business-setup', builder: (_, _) => const MapScreen()),
    GoRoute(path: '/product-create', builder: (_, _) => const ProductScreen()),
    GoRoute(path: '/recover-email', builder: (_, _) => const RecoverEmailScreen()),
    GoRoute(path: '/recover-sent', builder: (_, _) => const RecoverSentScreen()),
    GoRoute(path: '/recover-user', builder: (_, _) => const RecoverUserScreen()),
    GoRoute(path: '/verify-code', builder: (_, _) => const VerifyCodeScreen()),
    GoRoute(path: '/home', builder: (_, _) => const HomeScreen()),
    GoRoute(path: '/perfil', builder: (_, state) => PerfilScreen(initialTab: _tabIndex(state.uri.queryParameters['tab']))),
    GoRoute(path: '/cupones', builder: (_, _) => const MisCuponesScreen()),
    GoRoute(path: '/guardados', builder: (_, state) => GuardadosScreen(initialSub: state.uri.queryParameters['tab'] == 'puntos' ? 1 : 0)),
    GoRoute(path: '/solicitudes', builder: (_, state) => SolicitudesScreen(initialSub: state.uri.queryParameters['tab'] == 'enviadas' ? 1 : 0)),
    GoRoute(path: '/historial', builder: (_, state) => HistorialScreen(initialSub: state.uri.queryParameters['tab'] == 'enviados' ? 1 : 0)),
    GoRoute(path: '/crear-cupon', builder: (_, _) => const CrearCuponScreen()),
    GoRoute(path: '/seguidores', builder: (_, state) => SeguidoresScreen(initialTab: state.uri.queryParameters['tab'] == 'seguidores' ? 1 : 0)),
    GoRoute(path: '/solicitud-cupon', builder: (_, _) => const SolicitudCuponScreen()),
    GoRoute(path: '/solicitud-canje', builder: (_, _) => const SolicitudCanjeScreen()),
    GoRoute(path: '/canjear-puntos', builder: (_, state) => CanjearPuntosScreen(forceInsufficient: state.uri.queryParameters['estado'] == 'sin-puntos')),
    GoRoute(path: '/mostrar-qr', builder: (_, _) => const MostrarQrScreen()),
    GoRoute(path: '/sin-puntos', builder: (_, _) => const SinPuntosScreen()),
    GoRoute(path: '/gracias-visitar', builder: (_, _) => const GraciasVisitarScreen()),
    GoRoute(path: '/cupon-listo', builder: (_, state) => CuponListoScreen(tipo: state.uri.queryParameters['tipo'] == 'personalizado' ? 'personalizado' : 'consumo')),
    GoRoute(path: '/explorar', builder: (_, _) => const ExplorarScreen()),
    GoRoute(path: '/buscar-resultados', builder: (_, _) => const BuscarResultadosScreen()),
    GoRoute(path: '/usar-cupon', builder: (_, _) => const UsarCuponScreen()),
    GoRoute(path: '/mostrar-codigo', builder: (_, _) => const MostrarCodigoScreen()),
    GoRoute(path: '/gracias-cupon', builder: (_, _) => const GraciasCuponScreen()),
    GoRoute(path: '/points-help', builder: (_, _) => const PointsHelpScreen()),
    GoRoute(path: '/email-verification', builder: (_, _) => const EmailVerificationScreen()),
    GoRoute(path: '/suggested-accounts', builder: (_, _) => const SuggestedAccountsScreen()),
    GoRoute(path: '/negocio', builder: (_, state) => BusinessPublicProfileScreen(initialTab: _tabIndex(state.uri.queryParameters['tab']))),
    GoRoute(path: '/negocio-seguidores', builder: (_, state) => BusinessFollowersScreen(initialTab: state.uri.queryParameters['tab'] == 'seguidores' ? 1 : 0)),
    GoRoute(path: '/mensajes', builder: (_, state) => MessagesScreen(initialTab: state.uri.queryParameters['tab'] == 'notificaciones' ? 1 : 0)),
    GoRoute(path: '/chat', builder: (_, _) => const ChatScreen()),
    GoRoute(path: '/mapa-negocio', builder: (_, _) => const BusinessMapScreen()),
    GoRoute(path: '/configuracion', builder: (_, _) => const SettingsMenuScreen()),
    GoRoute(path: '/editar-cuenta', builder: (_, _) => const EditAccountScreen()),
    GoRoute(path: '/editar-perfil-config', builder: (_, _) => const EditProfileSettingsScreen()),
    GoRoute(path: '/editar-producto', builder: (_, _) => const EditProductScreen()),
    GoRoute(path: '/bloqueados', builder: (_, _) => const BlockedAccountsScreen()),
    GoRoute(path: '/suscripcion', builder: (_, _) => const SubscriptionScreen()),
    GoRoute(path: '/permisos', builder: (_, _) => const PermissionsScreen()),
    GoRoute(path: '/terminos', builder: (_, _) => const TermsScreen()),
    GoRoute(path: '/ayuda', builder: (_, _) => const HelpScreen()),
    GoRoute(path: '/lector-qr', builder: (_, _) => const QrScannerScreen()),
    GoRoute(path: '/historial-detalle', builder: (_, _) => const HistorialDetailScreen()),
    GoRoute(path: '/producto-detalle', builder: (_, _) => const ProductDetailScreen()),
    GoRoute(path: '/cargando', builder: (_, _) => const LoadingStateScreen()),
    GoRoute(path: '/error', builder: (_, _) => const ErrorStateScreen()),
    GoRoute(path: '/cargar-foto', builder: (_, _) => const PhotoPickerScreen()),
    GoRoute(path: '/mapa-cargando', builder: (_, _) => const MapLoadingScreen()),
    GoRoute(path: '/mapa-error', builder: (_, _) => const MapErrorScreen()),
    GoRoute(path: '/suscripcion-activa', builder: (_, _) => const SubscriptionStatusScreen(active: true)),
    GoRoute(path: '/plan-gratis', builder: (_, _) => const SubscriptionStatusScreen(active: false)),
  ],
);

void _applySystemUI() => SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _applySystemUI();
  SystemChrome.setSystemUIChangeCallback((_) async {
    await Future.delayed(const Duration(seconds: 3));
    _applySystemUI();
  });
  runApp(const CuponixApp());
}

class CuponixApp extends StatefulWidget {
  const CuponixApp({super.key});

  @override
  State<CuponixApp> createState() => _CuponixAppState();
}

class _CuponixAppState extends State<CuponixApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _applySystemUI();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(title: 'Cuponix', theme: AppTheme.theme, routerConfig: _router, debugShowCheckedModeBanner: false);
  }
}
