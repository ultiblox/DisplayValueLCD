#include "DisplayValueLCD.h"
#include "LoggerConfig.h"  // Include logging configuration
#include "SerialLogger.h"   // Use SerialLogger

DisplayValueLCD display(0x27, 16, 2);

void setup() {
    Serial.begin(115200);
    Serial.println("Serial started...");  // Fallback for serial output
    LOG_INFO("Initializing Display...");
    display.init();
    display.setLabel("Sensor Reading");
    LOG_INFO("Display setup complete.");
}

void loop() {
    String value = "25%";
    display.updateValue(value);
    //LOG_DEBUG("Value updated on display: " + String(value));
    delay(1000);
}
