#include "DisplayValueLCD.h"
#include "LoggerConfig.h"  // Include logging configuration
#include "SerialLogger.h"   // Use SerialLogger

DisplayValueLCD display(0x27, 16, 2);

int i = 0;

void setup() {
    Serial.begin(115200);
    Serial.println("Serial started...");  // Fallback for serial output
    //LOG_INFO("Initializing Display...");
    display.init();
    display.setLabel("Sensor Reading");
    display.setValue("...");
    display.setSuffix("%");
    delay(1000);
    //LOG_INFO("Display setup complete.");
}

void loop() {
    i++;
    display.setValue(i);
    //LOG_DEBUG("Value updated on display: " + String(value));
    delay(1000);
}
