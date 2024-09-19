#include "DisplayValueLCD.h"

DisplayValueLCD::DisplayValueLCD(uint8_t address, uint16_t cols, uint16_t rows) : lcd(address, cols, rows), numCols(cols) {}

void DisplayValueLCD::init() {
    lcd.init();
    lcd.backlight();
    clear();
}

void DisplayValueLCD::clear() {
    lcd.clear();
}

int DisplayValueLCD::calculateStartPosition(const String& text) {
    int len = text.length();
    int pos = (numCols - len) / 2;
    return pos > 0 ? pos : 0;
}

void DisplayValueLCD::setLabel(const String& label) {
    if (label != lastLabel) {
        lastLabel = label;
        clear(); // Optional: Clear only if you think necessary for all label updates
        lcd.setCursor(calculateStartPosition(label), 0);
        lcd.print(label);
    }
}

void DisplayValueLCD::updateValue(const String& value) {
    if (value != lastValue) {
        lastValue = value;
        lcd.setCursor(0, 1);
        lcd.print("                "); // Clear the previous value
        lcd.setCursor(calculateStartPosition(value), 1);
        lcd.print(value);
    }
}

