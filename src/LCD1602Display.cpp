#include "LCD1602Display.h"

LCD1602Display::LCD1602Display(uint8_t address, uint16_t cols, uint16_t rows) : lcd(address, cols, rows) {}

void LCD1602Display::init() {
    lcd.init();
    lcd.backlight();
}

void LCD1602Display::clear() {
    lcd.clear();
}

void LCD1602Display::setLabel(const String& label) {
    lcd.setCursor(0, 0);
    lcd.print(label);
}

void LCD1602Display::updateValue(const String& value) {
    lcd.setCursor(0, 1);
    lcd.print(value);
}
