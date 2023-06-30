import 'dart:io';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/app_assets.dart';
import '../../../config/app_styles.dart';
import '../../../generated/l10n.dart';
import '../../../globals.dart';

class AboutPage extends StatelessWidget {
  final _bgHeight = 240.0;
  final _avatarHeight = 160.0;
  final _iconHeight = 60.0;

  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).aboutPageTitle),
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
                          launchUrl(
                              Uri.parse(S.of(context).aboutPageUrlLinkedIn));
                        },
                        child: const CircleAvatar(
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
                          launchUrl(
                              Uri.parse(S.of(context).aboutPageUrlGitHub));
                        },
                        child: const CircleAvatar(
                          child: Icon(
                            MdiIcons.github,
                            size: AppStyles.iconSizeXLarge,
                          ),
                        ),
                      ),
                    )
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
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: AppStyles.sizeXLarge,
              ),
              FutureBuilder<AppInfoResult>(
                future: getIt<AppInfoFacade>().getInfo(),
                builder: (BuildContext context,
                    AsyncSnapshot<AppInfoResult> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final packageInfo = snapshot.data;
                    return ListTile(
                      leading: const Icon(Icons.info_outline),
                      title: Text(S.of(context).aboutPageVersion),
                      subtitle: Text(
                        'v${packageInfo?.version}${Platform.isIOS ? '-${appFlavor.value}' : ''} (${packageInfo?.buildNumber})',
                      ),
                      onTap: () {},
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
            ],
          ),
        ));
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      height: _bgHeight + (_avatarHeight / 2),
      child: Stack(children: [
        Positioned(
          child: SizedBox(
              height: _bgHeight,
              width: double.infinity,
              child: Image.asset(
                AppAssets.imageAboutBg,
                fit: BoxFit.cover,
              )),
        ),
        Positioned(
            bottom: 0,
            left: (MediaQuery.of(context).size.width / 2) - (_avatarHeight / 2),
            child: SizedBox(
                height: _avatarHeight,
                width: _avatarHeight,
                child: const CircleAvatar(
                  backgroundImage: AssetImage(AppAssets.imageAboutMe),
                )))
      ]),
    );
  }
}
