# BLE Temperature Peripheral + Central

This Project shows how to use  Bluetooth® Low Energy (BLE) to send temperature data via the [Arduino Nano 33 BLE Sense REV2](https://store.arduino.cc/products/nano-33-ble-sense-rev2) (peripheral) to an Android/iOS app (central). The central uses a single code base for both iOS and Android and is developed with the [Flutter](https://flutter.dev/) cross platform framework.



https://github.com/d-wolf/flutter_ble_arduino_temperature/assets/3867384/bda0d269-b9e3-4126-b2c4-27b309e74c9d



## Setup the Peripheral
1. Go through the setup guide of the [Arduino Nano 33 BLE Sense REV2](https://docs.arduino.cc/hardware/nano-33-ble-sense-rev2).
2. Open the Arduino IDE and add install both [ArduinoBLE](https://www.arduino.cc/reference/en/libraries/arduinoble/) and [Arduino_HS300x](https://github.com/arduino-libraries/Arduino_HS300x). If you are interested in more information about Bluetooth Low Energy and the [ArduinoBLE](https://www.arduino.cc/reference/en/libraries/arduinoble/) library, check out the [link](https://docs.arduino.cc/tutorials/nano-33-ble-sense/ble-device-to-device).
3. Open the [peripheral.ino](peripheral/peripheral.ino) file and hit the upload button.
4. The peripheral is setup successfully when the serial monitor prints `Bluetooth® device active, waiting for connections...`. 

## Setup the Central
1. First setup the crossplattform framework [Flutter](https://docs.flutter.dev/get-started/install).
2. Since the project consists of multiple packages (Presentation, Domain & Core) we are going to install [MELOS](https://melos.invertase.dev/getting-started) to handle them effectively.
3. Go to the [project folder](central/ble_temperature/) and run run `melos run init`. 

The app has two build variants `prod` and `sim`. The `prod` variant connects to a real physical device whereas the `sim` variant just emulates one. So to run the app you dont really need a physical device at all. Just run the `sim` variant. To do so call `flutter run --release --flavor sim -t lib/main_sim.dart`. For the prod variant call `flutter run --release --flavor prod -t lib/main_prod.dart`.

## Run CI
* `git tag v<major>.<minor>.<version>`
* `git push origin --tags`

## Sources
* https://docs.flutter.dev/get-started/install
* https://melos.invertase.dev/getting-started
* https://github.com/PhilipsHue/flutter_reactive_ble
* https://github.com/arduino-libraries/Arduino_HS300x
* https://github.com/arduino-libraries/ArduinoBLE
* https://github.com/arduino-libraries/ArduinoBLE/blob/master/examples/Peripheral/BatteryMonitor/BatteryMonitor.ino
* https://docs.arduino.cc/hardware/nano-33-ble-sense-rev2
* https://docs.arduino.cc/tutorials/nano-33-ble-sense/ble-device-to-device
