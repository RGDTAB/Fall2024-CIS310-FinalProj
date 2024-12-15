import 'dart:io';

import 'package:ble_temperature/core/app_globals.dart';
import 'package:ble_temperature/core/assets/app_assets.dart';
import 'package:ble_temperature/core/styles/app_styles.dart';
import 'package:ble_temperature/generated/l10n.dart';
import 'package:ble_temperature/src/about/presentation/cubit/about_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final _bgHeight = 240.0;
  final _avatarHeight = 160.0;
  final _iconHeight = 60.0;

  @override
  void initState() {
    super.initState();
    context.read<AboutCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).aboutPageTitle),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(
              height: AppStyles.sizeXLarge,
            ),
            Center(
              child: Text(
                S.of(context).aboutPageHeaderTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Center(
              child: Text(
                S.of(context).aboutPageHeaderSubtitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(
              height: AppStyles.sizeXLarge,
            ),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: _iconHeight,
                    width: _iconHeight,
                    child: InkWell(
                      onTap: () {
                        context
                            .read<AboutCubit>()
                            .launchUrl(S.of(context).aboutPageUrlLinkedIn);
                      },
                      child: CircleAvatar(
                        child: Icon(
                          MdiIcons.linkedin,
                          size: AppStyles.iconSizeXLarge,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: AppStyles.sizeXLarge,
                  ),
                  const VerticalDivider(
                    thickness: 1,
                    width: 1,
                    indent: AppStyles.sizeMedium,
                    endIndent: AppStyles.sizeMedium,
                  ),
                  const SizedBox(
                    width: AppStyles.sizeXLarge,
                  ),
                  SizedBox(
                    height: _iconHeight,
                    width: _iconHeight,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        context
                            .read<AboutCubit>()
                            .launchUrl(S.of(context).aboutPageUrlGitHub);
                      },
                      child: CircleAvatar(
                        child: Icon(
                          MdiIcons.github,
                          size: AppStyles.iconSizeXLarge,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: AppStyles.sizeXLarge,
            ),
            Padding(
              padding: AppStyles.edgeInsetsLarge,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).aboutPageTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: AppStyles.sizeSmall,
                  ),
                  Text(
                    S.of(context).aboutPageText,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: AppStyles.sizeXLarge,
            ),
            BlocBuilder<AboutCubit, AboutState>(
              builder: (BuildContext context, state) => switch (state) {
                AboutStateLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                AboutStateUpdate(appInfoResult: final info) => ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: Text(S.of(context).aboutPageVersion),
                    subtitle: Text(
                      'v${info.version}'
                      '${Platform.isIOS ? '-${customAppFlavor.value}' : ''}'
                      '(${info.buildNumber})',
                    ),
                    onTap: () {},
                  )
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: _bgHeight + (_avatarHeight / 2),
      child: Stack(
        children: [
          Positioned(
            child: SizedBox(
              height: _bgHeight,
              width: double.infinity,
              child: Image.asset(
                AppAssets.imageAboutBg,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: (MediaQuery.of(context).size.width / 2) - (_avatarHeight / 2),
            child: SizedBox(
              height: _avatarHeight,
              width: _avatarHeight,
              child: const CircleAvatar(
                backgroundImage: AssetImage(AppAssets.imageAboutMe),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
