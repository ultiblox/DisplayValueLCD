#ifndef DisplayValueLCD_h
#define DisplayValueLCD_h

#include "DisplayValueCommon.h"
#include <LCDI2C.h>

class DisplayValueLCD : public DisplayValueCommon {
private:
    LCDI2C lcd;
    uint16_t numCols;
    char lastLabel[32];   // Fixed-size buffer for the label
    char lastValue[32];   // Fixed-size buffer for the last displayed value
    char suffix[8];       // Increased buffer size for the suffix

public:
    DisplayValueLCD(uint8_t address, uint16_t cols, uint16_t rows);
    void init() override;
    void clear() override;
    void setLabel(const char* value) override;
    void setLabel(const __FlashStringHelper* value) override;
    
    void setValue(const char* value) override;
    void setValue(int value) override;
    
    void setSuffix(const char* value) override;
    int calculateStartPosition(const char* value);
};

#endif
