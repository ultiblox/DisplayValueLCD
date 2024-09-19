# DisplayValueLCD Library

## Overview
The `DisplayValueLCD` library provides a high-level interface for interacting with a 16x2 character LCD display via I2C communication. It allows users to set labels and update values on the display with simple commands.

## Features
- Supports I2C communication for 16x2 LCD screens.
- Allows setting labels and updating values dynamically.
- Clears the display as needed.

## Usage
### Initialization
```cpp
#include "DisplayValueLCD.h"
DisplayValueLCD display(0x27, 16, 2); // I2C address 0x27, 16 columns, 2 rows
```
### Set Label and Update Value
```cpp
display.setLabel("Sensor Reading");
display.updateValue("25%");
```
### Example
Refer to the `examples/hello-world/hello-world.ino` sketch for full usage.

## Dependencies
- LCDI2C Library
- Arduino Core Library

## License
This library is open source, distributed under the MIT License.