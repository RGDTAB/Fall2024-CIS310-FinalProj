#include <ArduinoBLE.h>
#include <Arduino_HS300x.h>
#include <PDM.h>
#include <Arduino_APDS9960.h>

static const int VALUE_SIZE = 20;

static const char channels = 1;
// default PCM output frequency
static const int frequency = 16000;
// Buffer to read samples into, each sample is 16-bits
short sampleBuffer[512];
// Number of audio samples read
volatile int samplesRead;
short maxNoise = 0;
int averageALight;
int sum = 0.0;
int reads = 0;

BLEService dataService = BLEService("00000000-5EC4-4083-81CD-A10B8D5CF6EC");
BLECharacteristic dataCharacteristic = BLECharacteristic("00000001-5EC4-4083-81CD-A10B8D5CF6EC", BLERead | BLENotify, VALUE_SIZE);

long previousMillis = 0;

void setup() {
  // initialize serial communication
  Serial.begin(9600);
  while (!Serial);

  PDM.onReceive(onPDMdata);

  if (!HS300x.begin()) {
    Serial.println("Failed to initialize HS300x.");
    while (1);
  }

  // initialize the built-in LED pin to indicate when a central is connected
  pinMode(LED_BUILTIN, OUTPUT);

  if (!BLE.begin()) {
    Serial.println("starting BLE failed!");
    while (1);
  }

  if (!PDM.begin(channels, frequency)) {
    Serial.println("Failed to start PDM!");
    while (1);
  }

  if (!APDS.begin()) {
    Serial.println("Error initializing APDS-9960 sensor.");
  }

  BLE.setLocalName("SLP_DATA");
  BLE.setDeviceName("SLP_DATA");
  // add the temperature characteristic
  dataService.addCharacteristic(dataCharacteristic);
  // add the service
  BLE.addService(dataService);
  // set initial value for this characteristic
  dataCharacteristic.writeValue("0.0");
  // start advertising
  BLE.advertise();

  Serial.println("Bluetooth® device active, waiting for connections...");
}

void loop() {
  // wait for a Bluetooth® Low Energy central
  BLEDevice central = BLE.central();
  while (!APDS.colorAvailable()) {
    delay(5);
  }

  // if a central is connected to the peripheral:
  if (central) {
    Serial.print("Connected to central: ");
    // print the central's BT address:
    Serial.println(central.address());
    // turn on the LED to indicate the connection
    digitalWrite(LED_BUILTIN, HIGH);


    // while the central is connected
    // update temperature every 5000ms
    while (central.connected()) {
      int r, g, b, a;
      long currentMillis = millis();

      if (APDS.colorAvailable()) {
        APDS.readColor(r, g, b, a);
        sum += a;
        reads++;
      }

      for (int i = 0; i < samplesRead; i++) {
        if(channels == 2) {
         Serial.print("L:");
          Serial.print(sampleBuffer[i]);
         Serial.print(" R:");
          i++;
        }
        if (sampleBuffer[i] > maxNoise) {
          maxNoise = sampleBuffer[i];
        }
        
      }

      if (currentMillis - previousMillis >= 5000) {
        previousMillis = currentMillis;
        averageALight = sum / reads;
        updateReadings(maxNoise, averageALight);
        maxNoise = 0;
        sum = 0.0;
        reads = 0;
      }
    }

    // turn off the LED after disconnect
    digitalWrite(LED_BUILTIN, LOW);
    Serial.print("Disconnected from central: ");
    Serial.println(central.address());
  }
}

void updateReadings(short loudest, int light) {
  int temp = HS300x.readTemperature(FAHRENHEIT) * 10;
  int hum = HS300x.readHumidity() * 10;

  char buffer[VALUE_SIZE];
  for (int i = (VALUE_SIZE / 4) - 1; i >= 0; i--) {
    buffer[i] = (temp % 10) + '0';
    temp /= 10;
  }
  for (int i = (VALUE_SIZE / 2) - 1; i >= VALUE_SIZE / 4; i--) {
    buffer[i] = (hum % 10) + '0';
    hum /= 10;
  }
  for (int i = (VALUE_SIZE * 3 / 4) - 1; i >= VALUE_SIZE / 2; i--) {
    buffer[i] = (loudest % 10) + '0';
    loudest /= 10;
  }
  for (int i = VALUE_SIZE - 1; i >= VALUE_SIZE * 3 / 4; i--) {
    buffer[i] = (light % 10) + '0';
    light /= 10;
  }

  dataCharacteristic.writeValue(buffer, VALUE_SIZE, true);
}

void onPDMdata() {
  // Query the number of available bytes
  int bytesAvailable = PDM.available();

  // Read into the sample buffer
  PDM.read(sampleBuffer, bytesAvailable);

  // 16-bit, 2 bytes per sample
  samplesRead = bytesAvailable / 2;
}