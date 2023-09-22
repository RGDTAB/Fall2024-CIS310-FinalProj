import 'package:ble_temperature/core/services/router_service.dart';
import 'package:ble_temperature/core/styles/app_styles.dart';
import 'package:ble_temperature/generated/l10n.dart';
import 'package:ble_temperature/src/bluetooth/domain/enums/enums.dart';
import 'package:ble_temperature/src/bluetooth/presentation/cubit/init_ble/init_ble_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitBlePage extends StatelessWidget {
  const InitBlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<InitBleCubit, InitBleState>(
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
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: AppStyles.sizeLarge),
                Text(S.of(context).bleInitWaiting),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
