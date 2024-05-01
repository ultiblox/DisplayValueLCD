#ifndef LCD1602Display_h
#define LCD1602Display_h

#include "DisplayInterface.h"
#include <LiquidCrystal_I2C.h>

class LCD1602Display : public DisplayInterface {
private:
    LiquidCrystal_I2C lcd;
public:
    LCD1602Display(uint8_t address, uint16_t cols, uint16_t rows);
    void init() override;
    void clear() override;
    void setLabel(const String& label) override;
    void updateValue(const String& value) override;
};

#endif
