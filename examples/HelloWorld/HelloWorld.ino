#include "DisplayValueLCD.h"

DisplayValueLCD display(0x27, 16, 2);  // I2C address and LCD size

void setup() {
    Serial.begin(115200);
    display.init();
    display.setLabel("Sensor Reading");
    display.setSuffix("%");
    delay(1000);
}

void loop() {
    int sensorValue = analogRead(A0);
    display.setValue(sensorValue);
    delay(1000);
}
