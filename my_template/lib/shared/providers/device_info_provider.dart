import 'package:device_info_plus/device_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_info_provider.g.dart';

// TODO remember to init this in main
//  see https://riverpod.dev/docs/concepts/scopes#initialization-of-synchronous-provider-for-async-apis
@Riverpod(keepAlive: true)
BaseDeviceInfo deviceInfo(DeviceInfoRef ref) => throw UnimplementedError();

/*
      NOTE: BaseDeviceInfo is the superclass for all the Infos, so just use the cast to ge the specific info

      final androidInfo = ref.read(deviceInfoProvider) as AndroidDeviceInfo;
      final iosInfo = ref.read(deviceInfoProvider) as IosDeviceInfo;
*/
