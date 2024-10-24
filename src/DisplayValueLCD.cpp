#include "DisplayValueLCD.h"
#include "SerialLogger.h"
#include <string.h>  // For strncpy and strcmp

DisplayValueLCD::DisplayValueLCD(uint8_t address, uint16_t cols, uint16_t rows)
    : lcd(address, cols, rows), numCols(cols) {
    lastLabel[0] = '\0';  // Initialize with empty strings
    lastValue[0] = '\0';
    suffix[0] = '\0';
}

void DisplayValueLCD::init() {
    lcd.init();
    lcd.backlight();  // Backlight can be turned off when not needed to save power
    clear();
}

void DisplayValueLCD::clear() {
    lcd.clear();
}

void DisplayValueLCD::setLabel(const char* value) {
    if (value == nullptr) return;  // Check for null input

    if (strcmp(lastLabel, value) != 0) {  // Only update if the label has changed
        // Clear the row first by printing spaces (adjust based on your LCD's width)
        lcd.setCursor(0, 0);
        lcd.print("                ");  // Assuming a 16-character wide LCD

        // Copy the new label
        strncpy(lastLabel, value, sizeof(lastLabel) - 1);  // Safely copy to lastLabel
        lastLabel[sizeof(lastLabel) - 1] = '\0';  // Ensure null termination

        // Set the cursor and print the new label
        lcd.setCursor(calculateStartPosition(lastLabel), 0);  // Center the label
        lcd.print(lastLabel);
    }
}

void DisplayValueLCD::setLabel(const __FlashStringHelper* value) {
    char buffer[16];  // Adjust size as needed
    strcpy_P(buffer, (PGM_P)value);
    setLabel(buffer);  // Call the original setLabel with the converted string
}

void DisplayValueLCD::setValue(const char* value) {
    if (value == nullptr) return;

    //Logger.debug("Current suffix: ");
    //Logger.debugln(suffix);  // Log the current suffix to check if it's being corrupted

    char fullValue[17];  // Buffer size to fit the full display (16 characters + null terminator)
    snprintf(fullValue, sizeof(fullValue), "%s%s", value, suffix);  // Safely concatenate value + suffix

    //Logger.debug("Displaying value: ");
    //Logger.debugln(fullValue);  // Log the current suffix to check if it's being corrupted

    if (strcmp(lastValue, fullValue) != 0) {
        lcd.setCursor(0, 1);
        lcd.print("                ");  // Clear the row

        strncpy(lastValue, fullValue, sizeof(lastValue) - 1);  // Copy the full value into lastValue
        lastValue[sizeof(lastValue) - 1] = '\0';  // Ensure null-termination

        lcd.setCursor(calculateStartPosition(fullValue), 1);  // Keep the centering intact
        lcd.print(fullValue);  // Display the value + suffix
    }
}

void DisplayValueLCD::setValue(int value) {
    char valueStr[8];  // Smaller buffer to conserve memory
    snprintf(valueStr, sizeof(valueStr), "%d", value);
    setValue(valueStr);  // Call the char* version of setValue
}

void DisplayValueLCD::setSuffix(const char* value) {
    if (value == nullptr) return;  // Check for null input
    // Safely copy the suffix with size constraints
    strncpy(suffix, value, sizeof(suffix) - 1);
    suffix[sizeof(suffix) - 1] = '\0';  // Ensure null termination
}

int DisplayValueLCD::calculateStartPosition(const char* value) {
    int len = strlen(value);
    int pos = (numCols - len) / 2;
    return pos > 0 ? pos : 0;  // Calculate the position to center the text
}
