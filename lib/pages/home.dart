import 'package:flutter/material.dart';
import 'package:qrcode/bloc/bloc.dart';
import 'package:qrcode/config/colors.dart';
import 'package:qrcode/routes/router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthStateLogout) {
                context.goNamed(Routes.LOGIN);
              }
            },
            builder: (context, state) {
              if (state is AuthStateLoading) {
                return CircularProgressIndicator();
              }
              return Icon(Icons.logout);
            },
          ),
          onPressed: () {
            context.read<AuthBloc>().add(AuthEventLogout());
          },
        ),
        appBar: AppBar(
          title: Text("OrenjiBox"),
        ),
        body: GridView.builder(
          padding: EdgeInsets.all(20),
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
          itemBuilder: (context, index) {
            late String title;
            late IconData icon;
            late VoidCallback onTap;

            switch (index) {
              case 0:
                title = "Add Products";
                icon = Icons.add_circle_outline_outlined;
                onTap = () => context.goNamed(Routes.PRODUCT_ADD);
                break;
              case 1:
                title = "List Products";
                icon = Icons.list_alt_outlined;
                onTap = () => context.goNamed(Routes.PRODUCTS);
                break;
              case 2:
                title = "Scan QR";
                icon = Icons.qr_code;
                onTap = () {};
                break;
              case 3:
                title = "Catalog";
                icon = Icons.document_scanner_outlined;
                onTap = () {};
                break;
              default:
            }

            return Material(
              color: AppColors.primaryColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: onTap,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 40,
                        width: 40,
                        child: Icon(
                          icon,
                          size: 40,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      title,
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
