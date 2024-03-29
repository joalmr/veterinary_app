import 'package:get/get.dart';
import 'package:vet_app/config/variables_global.dart';
import 'package:vet_app/middleware/global_middleware.dart';
import 'package:vet_app/src/_auth/presentation/login/pages/login.dart';
import 'package:vet_app/src/_error404/view_404.dart';
import 'package:vet_app/src/_pet/presentation/pages/pet_history/view.dart';
import 'package:vet_app/src/bookings/presentation/pages/atender/atender_main.dart';
import 'package:vet_app/src/calendar/presentation/pages/calendar.dart';
import 'package:vet_app/src/chat/presentation/chats_main.dart';
import 'package:vet_app/src/config/presentation/pages/config_main.dart';
import 'package:vet_app/src/establishments/presentation/pages/_children/create/crea_vet.dart';
import 'package:vet_app/src/establishments/presentation/pages/_children/show/show_vet.dart';
import 'package:vet_app/src/home/presentation/pages/home.dart';
import 'package:vet_app/src/offers/presentation/pages/offers.dart';
import 'package:vet_app/src/products/expenses/presentation/expenses.dart';
import 'package:vet_app/src/registros/presentation/pages/attentions.dart';
import 'package:vet_app/src/establishments/presentation/pages/establishments.dart';
import 'package:vet_app/src/products/sales/presentation/sales.dart';
import 'package:vet_app/src/stats/presentation/pages/stats.dart';
import 'package:vet_app/src/user_clients/presentation/user_clients.dart';

class NameRoutes {
  static const String splash = '/';
  // static const  String register = '/register';
  static const String login = '/login';
  static const String home = '/home';
  static const String calendar = '/calendar';
  static const String attentions = '/attentions';
  static const String stats = '/stats';
  static const String offers = '/offers';
  static const String establishments = '/establishments';
  static const String chats = '/chats';
  static const String clientes = '/clients';
  static const String config = '/config';
  static const String sales = '/sales'; //? ventas
  static const String expenses = '/expenses'; //? egresos
  static const String atenderBooking = '/booking'; //? atender
  static const String error404 = '/error404'; //? error

}

class AppPages {
  static final unknownRoutePage = GetPage(
    name: NameRoutes.error404,
    page: () => View404(),
  );

  static final List<GetPage> pages = [
    unknownRoutePage,
    GetPage(
      name: NameRoutes.splash,
      // page: () => SplashView(),
      page: () => prefUser.tokenHas() == true &&
              prefUser.vetDataHas() == true &&
              prefUser.vetIdSupaHas() == true
          ? HomeMain()
          : LoginMain(),
    ),
    GetPage(
      name: NameRoutes.login,
      page: () => LoginMain(),
    ),
    GetPage(
      name: NameRoutes.home,
      page: () => HomeMain(),
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: NameRoutes.atenderBooking,
      page: () => AtenderMain(),
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: NameRoutes.calendar,
      page: () => CalendarMain(),
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: NameRoutes.attentions,
      page: () => AttentionsMain(),
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: NameRoutes.stats,
      page: () => StatsMain(),
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: NameRoutes.offers,
      page: () => OffersMain(),
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: NameRoutes.establishments,
      page: () => EstablishmentsMain(),
      middlewares: [GlobalMiddleware()],
      children: [
        GetPage(
          name: '/create',
          page: () => CreateVetMain(),
        ),
        GetPage(
          name: '/show',
          page: () => ShowVetMain(),
        ),
      ],
    ),
    GetPage(
      name: NameRoutes.chats,
      page: () => ChatsMain(),
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: NameRoutes.clientes,
      page: () => UserClientsMain(),
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: NameRoutes.config,
      page: () => ConfigMain(),
      middlewares: [GlobalMiddleware()],
    ),
    //
    GetPage(
      name: '/history/:pet',
      page: () => PetHistoryPage(),
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: NameRoutes.sales,
      page: () => SalesMain(),
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: NameRoutes.expenses,
      page: () => ExpensesMain(),
      middlewares: [GlobalMiddleware()],
    ),
  ];
}
