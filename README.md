# UltiBlox DisplayValueLCD Library

*Easily display labels and values on an LCD screen with flexible formatting.*

[UltiBlox on GitHub](https://github.com/UltiBlox/DisplayValueLCD) | [UltiBlox Home](https://ultiblox.org)

## Overview

The `DisplayValueLCD` library simplifies displaying text and values on LCD screens, making it ideal for embedded projects that need flexible text displays. It provides options for centering text, adding suffixes (e.g., units), and clearing rows for updated display content.

## Features

- Display custom labels and values with optional suffixes.
- Center text automatically for a clear, balanced display.
- Clear lines as needed to refresh display content.
- Easily interchangeable with the `DisplayValueOLED` library for OLED displays.

## Compatibility

The `DisplayValueLCD` library is compatible with [`DisplayValueOLED`](https://github.com/ultiblox/DisplayValueOLED) for OLED screens. Both libraries share the same function signatures, allowing you to switch between LCD and OLED displays by simply changing the library declaration in your code.

## Installation

### Option 1: Arduino Library Manager Installation (Recommended)

1. Open the **Arduino IDE**.
2. Go to **Tools > Manage Libraries**.
3. Search for **UltiBlox-DisplayValueLCD** and click **Install**.
4. Access example sketches under **File > Examples > UltiBlox-DisplayValueLCD**.

### Option 2: Manual Installation (for Development and Customization)

1. **Clone the Repository**:
   
   ```bash
   git clone git@github.com:UltiBlox/DisplayValueLCD.git ~/workspace/DisplayValueLCD
   cd ~/workspace/DisplayValueLCD
   ```

2. **Prepare the Environment**:
   Run the `prepare.sh` script to set up dependencies:
   
   ```bash
   bash prepare.sh
   ```

3. **Install the Library**:
   
   - **Copy Installation**:
     
     ```bash
     bash install.sh
     ```
   - **Symlink Installation** (for active development):
     
     ```bash
     bash install-symlink.sh
     ```

4. **Build Examples**:
   Compile example sketches with:
   
   ```bash
   bash build.sh
   ```

## Dependencies

- **LCDI2C**: Required for LCD display communication.
- **Arduino Core Library**

## Examples

- **[HelloWorld.ino](examples/HelloWorld/HelloWorld.ino)**: Demonstrates setting up the display with a label and a sample value, continuously updating the displayed value from `A0`.

## Methods

### Initialize the Display

```cpp
init()
```

Initializes the LCD display and turns on the backlight.

### Clear the Display

```cpp
clear()
```

Clears the entire display content.

### Set the Label Text

```cpp
setLabel(const char* value)
```

Sets and centers a label text at the top of the display.

### Set the Value

```cpp
setValue(int value)
```

Displays the specified integer value on the display, centered for visibility.

### Set a Suffix for the Value

```cpp
setSuffix(const char* value)
```

Sets a suffix, such as a unit symbol, to be displayed next to the value.

## License

[This project is licensed under the UltiBlox License.](https://ultiblox.org/license)
