#include "DisplayValueLCD.h"
//#include "SerialLogger.h"   // Include SerialLogger for logging

DisplayValueLCD::DisplayValueLCD(uint8_t address, uint16_t cols, uint16_t rows) : lcd(address, cols, rows), numCols(cols) {}

void DisplayValueLCD::init() {

//    LOG_INFO("LCD initializing");

    lcd.init();
    lcd.backlight();
    clear();

//    LOG_INFO("LCD initialized with " + String(numCols) + " columns.");
}

void DisplayValueLCD::clear() {
    lcd.clear();
//    LOG_DEBUG("Display cleared.");
}

int DisplayValueLCD::calculateStartPosition(const String& text) {
    int len = text.length();
    int pos = (numCols - len) / 2;
    return pos > 0 ? pos : 0;
}

void DisplayValueLCD::setLabel(const String& label) {
    if (label != lastLabel) {
        lastLabel = label;
        clear();  // Optional: Clear only if necessary for label updates
        lcd.setCursor(calculateStartPosition(label), 0);
        lcd.print(label);
//        LOG_DEBUG("Label set: " + label);
    }
}

void DisplayValueLCD::updateValue(const String& value) {
    if (value != lastValue) {
        lastValue = value;
        lcd.setCursor(0, 1);
        lcd.print("                ");  // Clear the previous value
        lcd.setCursor(calculateStartPosition(value), 1);
        lcd.print(value);
//        LOG_DEBUG("Value updated: " + String(value));
    }
}
