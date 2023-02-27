# ENF Extraction from Videos

### 1. Static Global Shutter Algorithm

The main file that you will run is `global_static.m`, you have to change the name
of the video file, the first and last frame and the boundaries of the butterworth
bandpass filter depending on the aliases that you have mathematically calculated. 
In `TimeVer.m` file the excel file of ground-truth frequency also has to be changed.

Example: MVI_9131.AVI ->14/12/2022 23.47pm (white wall video, incandescent light) 


### 2. Global Shutter with Moving Content Algorithm

The main file that you will run is `superpix.m`, the same changes as before have to 
be made. In `Threshold.m` you also have to choose a static frame.

Example: MVI_9138 ->15/12/2022 00.01am (incandescent light)


### 3. Static Rolling Shutter Algorithm

The main file that you will run is `rolling_shutter.m`, the same changes as before 
have to made but pay attention on whether the CMOS sensor is horizontal or 
vertical and choose the functions accordingly.

Example: rolling_1 ->10/11/2022 17.20.03pm (white wall video, incandescent light) 

#### Access files
You can request the video files via email






