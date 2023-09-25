import 'package:ble_temperature/src/about/data/datasources/app_info_local_data_source.dart';
import 'package:ble_temperature/src/about/data/repositories/app_info_repository_impl.dart';
import 'package:ble_temperature/src/about/domain/entities/app_info.dart';
import 'package:ble_temperature/src/about/domain/repositories/app_info_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<AppInfoLocalDataSource>()])
import 'app_info_repository_impl_test.mocks.dart';

void main() {
  late MockAppInfoLocalDataSource dataSource;
  late AppInfoRepositoryImpl repository;

  setUp(() {
    dataSource = MockAppInfoLocalDataSource();
    repository = AppInfoRepositoryImpl(dataSource);
  });

  test(
      '[AppInfoRepositoryImpl]'
      'should be a subclass of [AppInfoRepository].', () async {
    expect(repository, isA<AppInfoRepository>());
  });

  test('Returns [AppInfo] successfully.', () async {
    const tInfo = AppInfo(
      appName: 'appName',
      packageName: 'packageName',
      version: '1',
      buildNumber: 'buildNumber',
    );

    when(dataSource.getInfo()).thenAnswer(
      (_) async => tInfo,
    );

    final result = await repository.getInfo();
    expect(result, const Right<AppInfo, dynamic>(tInfo));
  });
}
