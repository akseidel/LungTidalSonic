# LungTidalSonic

![](/Images/TheBigPicture.png)

-   A Processing + Arduino combination that records lung tidal spirometer readings on a Collins Vitalometer. The spirometer dome height is measured with an ultra-sonic distance sensor. Sensor readings are adjusted for air temperature and air humidity.
-   Used by the John Burroughs School, St. Louis, Mo.

![](/Images/TheScreen.png)    

## Documentation:  **[LungTidalManualPDF.pdf](ManualsLungTidal/LungTidalManualPDF.pdf)**

<img src="/Images/BoxDevice01.png" height="66%" width="66%">

<img src="/Images/BoxInside.png" height="66%" width="66%">

<img src="/Images/Pulley.png" height="66%" width="66%">

#### Download MacOS Application: **[LungTidalSonic.app](MacOSApplication/LungTidalSonic.app)**

#### Download USBSerial Driver for Duemilanove Arduino: **[FTDIUSBSerialDriver_v2_4_2.dmg](MacOSApplication/USBSerialPortDrivers/FTDIUSBSerialDriver_v2_4_2.dmg)**

## Background

-   This Collins Vitalometer is used by the science department at John Burroughs School, St. Louis, Mo.
-   In the mid 1980's this spirometer was hooked up to an Apple II computer via a game port. Bruce Westling coupled a potentiometer to the dial to sense the dial movement. The potentiometer's 270 degree shaft rotation limit prevented readings throughout the full dial range. An Applesoft Basic was devised to record the dial readings.
-   There always were some students having lung capacities larger than the measuring limit. This was a problem.
-   Eventually the science department phased out all older Apple computers that had been retained for using hookups such as this setup. In 2009 a Processing+Arduino system was created to read the original potentiometer on the schools computers running OSX. Processing version 1 code was initially used at that time where the application existed as a Java applet, but this was soon updated to Processing version 2 code which eventually discontinued the Java applet paradigm. The measuring limit continued to be a problem.
-   Spring 2018 modifications removed the potentiometer sensor and fitted an ultra-sonic sensor to directly sense the dome vertical movement. Within the black box sensor housing is a temperature/humidity sensor. The combined sensors provide a means to accurately measure the dome height with adequate precision. Software modifications were required both to the Arduino program and the Processing program, but the general scheme concepts remained. Processing version 3 code is used at this time.
-   (8/15/2018 AKS) 
