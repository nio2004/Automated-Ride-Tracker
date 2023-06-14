#include <TinyGPSPlus.h>
#include <Arduino.h>
#include <WiFi.h>
#include <FirebaseESP32.h>
#elif defined(ESP8266)
#include <ESP8266WiFi.h>
#include <FirebaseESP8266.h>
#elif defined(ARDUINO_RASPBERRY_PI_PICO_W)
#include <FirebaseESP8266.h>
#endif
// Provide the token generation process info.
#include <addons/TokenHelper.h>

// Provide the RTDB payload printing info and other helper functions.
#include <addons/RTDBHelper.h>

#define WIFI_SSID "wifi_name"
#define WIFI_PASSWORD "wifi_password"
#define API_KEY "your_api_key"
#define DATABASE_URL "automated-ride-tracker-default-rtdb.asia-southeast1.firebasedatabase.app" //<databaseName>.firebaseio.com or <databaseName>.<region>.firebasedatabase.app
#define USER_EMAIL "test1@gmail.com"
#define USER_PASSWORD "test123"

TinyGPSPlus gps;

FirebaseData fbdo;

FirebaseAuth auth;
FirebaseConfig config;

unsigned long sendDataPrevMillis = 0;

unsigned long count = 0;

void setup() {


  Serial.begin(9600);


  Serial2.begin(9600);

 WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();

  Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);

  /* Assign the api key (required) */
  config.api_key = API_KEY;

  /* Assign the user sign in credentials */
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;

  /* Assign the RTDB URL (required) */
  config.database_url = DATABASE_URL;

  /* Assign the callback function for the long running token generation task */
  config.token_status_callback = tokenStatusCallback; // see addons/TokenHelper.h
    Firebase.begin(&config, &auth);
 // Comment or pass false value when WiFi reconnection will control by your code or third party library
  Firebase.reconnectWiFi(true);

  Firebase.setDoubleDigits(5);
  delay(3000);


}


void loop() {


  //updateSerial();


  while (Serial2.available() > 0)


    if (gps.encode(Serial2.read()))


      displayInfo();


  if (millis() > 5000 && gps.charsProcessed() < 10)


  {


    Serial.println(F("No GPS detected: check wiring."));


    //while (true);
delay(2000);

  }


}


void displayInfo()


{


  Serial.print(F("Location: "));


  if (gps.location.isValid()){


    Serial.print("Lat: ");


    Serial.print(gps.location.lat(), 6);

  if (Firebase.ready()) 
  {

    Firebase.setInt(fbdo, "/gps-data/lat", gps.location.lat());
    Firebase.setInt(fbdo, "/gps-data/lng", gps.location.lng());
    delay(200);
  }


    Serial.print("Lng: ");


    Serial.print(gps.location.lng(), 6);


    Serial.println();


  }  


  else


  {


    Serial.println(F("INVALID"));

  }


}


void updateSerial()


{


  delay(500);


  while (Serial.available())


  {


    Serial2.write(Serial.read());//Forward what Serial received to Software Serial Port


  }


  while (Serial2.available())


  {


    Serial.write(Serial2.read());//Forward what Software Serial received to Serial Port


  }


}
