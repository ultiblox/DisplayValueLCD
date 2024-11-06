#ifndef DisplayValueLCD_h
#define DisplayValueLCD_h

#include <LCDI2C.h>

class DisplayValueLCD {
private:
    LCDI2C lcd;
    uint16_t numCols;
    char lastLabel[32];   // Fixed-size buffer for the label
    char lastValue[32];   // Fixed-size buffer for the last displayed value
    char suffix[8];       // Buffer size for the suffix

public:
    DisplayValueLCD(uint8_t address, uint16_t cols, uint16_t rows);
    void init();
    void clear();
    void setLabel(const char* value);
    void setLabel(const __FlashStringHelper* value);
    void setValue(const char* value);
    void setValue(int value);
    void setSuffix(const char* value);
    int calculateStartPosition(const char* value);
};

#endif