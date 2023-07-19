import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/app_routes.dart';
import '../../../config/app_styles.dart';
import '../../../generated/l10n.dart';
import '../../../globals.dart';
import '../../bloc/init_ble/init_ble_cubit.dart';

class InitBlePage extends StatelessWidget {
  const InitBlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InitBleCubit(bleFacade: getIt())..init(),
      child: BlocListener<InitBleCubit, InitBleState>(
        listener: (context, state) {
          if (state.state == BLEState.ready) {
            Navigator.of(context).pushReplacementNamed(Routes.scanPage);
          }
        },
        child: Scaffold(
            body: Center(
          child: Padding(
            padding: AppStyles.edgeInsetsLarge,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: AppStyles.sizeLarge),
                Text(S.of(context).bleInitWaiting),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
