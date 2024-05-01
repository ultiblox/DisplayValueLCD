#include "LCD1602Display.h"

LCD1602Display display(0x27, 16, 2);

void setup() {
    display.init();
    display.setLabel("Sensor Reading");
}

void loop() {
    display.updateValue("25%");
    delay(1000);
}
