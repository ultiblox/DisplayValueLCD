#include "LCD1602Display.h"

LCD1602Display::LCD1602Display(uint8_t address, uint16_t cols, uint16_t rows) 
    : lcd(address, cols, rows), numCols(cols) {}

void LCD1602Display::init() {
    lcd.init();
    lcd.backlight();
    clear();
}

void LCD1602Display::clear() {
    lcd.clear();
}

int LCD1602Display::calculateStartPosition(const String& text) {
    int len = text.length();
    int pos = (numCols - len) / 2; // Calculate the starting position to center text
    return pos > 0 ? pos : 0; // Ensure the position is not negative
}

void LCD1602Display::setLabel(const String& label) {
    lcd.setCursor(calculateStartPosition(label), 0);
    lcd.print("                "); // Clear the previous label
    lcd.setCursor(calculateStartPosition(label), 0);
    lcd.print(label);
}

void LCD1602Display::updateValue(const String& value) {
    lcd.setCursor(calculateStartPosition(value), 1);
    lcd.print("                "); // Clear the previous value
    lcd.setCursor(calculateStartPosition(value), 1);
    lcd.print(value);
}

