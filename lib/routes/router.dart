import 'package:go_router/go_router.dart';
import 'package:qrcode/pages/add_product.dart';
import 'package:qrcode/pages/detail_product.dart';
import 'package:qrcode/pages/error.dart';
import 'package:qrcode/pages/home.dart';
import 'package:qrcode/pages/login.dart';
import 'package:qrcode/pages/products.dart';
import 'package:firebase_auth/firebase_auth.dart';
export 'package:go_router/go_router.dart';
part 'route_name.dart';

// GoRouter configuration
final router = GoRouter(
  redirect: (context, state) {
    // CEK KONDISI SAAT INI (SUDAH LOGIN ATAU BELUM)
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser == null) {
      // tidak ada user yg login
      return "/login";
    } else {
      return null;
    }
  },
  errorBuilder: (context, state) => const ErrorPage(),
  routes: [
    GoRoute(
        name: Routes.HOME,
        path: '/',
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
              name: Routes.PRODUCTS,
              path: 'products',
              builder: (context, state) => const ProductsPage(),
              routes: [
                GoRoute(
                  name: Routes.PRODUCT_DETAIL,
                  path: ':id',
                  builder: (context, state) => DetailProductPage(
                      state.params['id'].toString(), state.queryParams),
                )
              ]),
          GoRoute(
            name: Routes.PRODUCT_ADD,
            path: 'add-products',
            builder: (context, state) => AddProductPage(),
          ),
        ]),
    GoRoute(
      name: Routes.LOGIN,
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
  ],
);
