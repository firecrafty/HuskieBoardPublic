# Huskie Board Firmware

---

### Language
The Huskie Board runs on the [Parallax Propeller microcontroller](https://www.parallax.com/catalog/microcontrollers/propeller/chips). The majority of our code is written in Spin, though there is some pasm (assembly) included. The development environment is available [here](https://www.parallax.com/downloads/propeller-tool-software-windows). 

---

### Object Heiarchy
* `main.spin`
  * `RR uart connection.spin`
    * `FASTSERIAL-080927.spin`
    * `adc124s021_x2.spin`
    * `Disabled Parallax Serial Terminal.spin`
    * `Serial_Lcd.spin`
      * `Simple_Serial.spin`
    * `LED Main.spin`
      * `Neopixel Driver.spin`
    * `SD Controller.spin`
      * `fsrw.spin`
        * `safe_spi.spin`
---
### File Descriptions

`Disabled Parallax Serial Terminal.spin` - Allows us to turn off the debugging software for release versions. `Parallax Serial Terminal.spin` can be used instead to enable debugging.

`FASTSERIAL-080927.spin` - Used to communicate with the RoboRio at a high baud rate.

`fsrw.spin` - FAT32 filesystem control for the SD card

`adc124s021_x2.spin` - Controls SPI communication with the onboard ADCs, as well as averaging of the ADC values.

`LED Main.spin` - Controls a strip of Neopixel LEDs on the robot. The patterns can be selected by the RoboRIO. More patterns can be added here.

`main.spin` - Top object file, initiates all processes. Also controls the 4 LEDs to indicate DIP switch positions.

`Neopixel Driver.spin` - Neopixel LED driver

`ProductionTesterWithMain.spin` - Used to test each Huskie Board on a custom fixture before shipping. This is technically what is on the Huskie Board when it is purchased, but if firmware needs to be reflashed by a user, they should flash `main.spin`.

`Propeller EEprom.spin` - Dependancy of `ProductionTesterWithMain.spin`, allows for saving data to the EEprom for permanent storage.

`RR uart connection.spin` - UART controller for connection between propeller and roboRIO

`safe_spi.spin` - SPI routines used for the SD card

`SD Controller.spin` - High level API for SD card control

`Serial_Lcd.spin` - High level interface for Parallax LCD displays

`Simple_Serial.spin` - A simple low baud rate serial object, for use with the LCD displays.
---

# How To Load Code
1. Run the Propeller Tool executable
2. Open "main.spin"
3. Compile and load to EEPROM (Run -> Compile Current -> Load EEPROM)

