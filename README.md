# DC_motor_voltage_Inversion
This is the final project of Course 4810 in Columbia University

## The designed voltage inversion system
<p align="center">
    <img src="https://github.com/Qincheng-Sheng/DC_motor_voltage_Inversion/blob/main/Picture/System.png" alt="system" width= 350">
</p>

## The Flow chart of the voltage inversion system
<p align="center">
    <img src="https://github.com/Qincheng-Sheng/DC_motor_voltage_Inversion/blob/main/Picture/Flow_chart.png" alt="system" width= 250">
</p>

## How to inverse the DC motor voltage

Step 1. Estimate the input signal waveform and get recoverd signal by using the hall sensor

<p align="center">
  <img src="https://github.com/Qincheng-Sheng/DC_motor_voltage_Inversion/blob/main/Picture/recover_signal.png" width="350" title="System">
</p>

Step 2. Compare the Fourier transform of the recovered signal and the input waveform

<p align="center">
  <img src="https://github.com/Qincheng-Sheng/DC_motor_voltage_Inversion/blob/main/Picture/FFT_sin.png" width="250" title="System">
  <img src="https://github.com/Qincheng-Sheng/DC_motor_voltage_Inversion/blob/main/Picture/FFT_square.png" width="250" title="System">
  <img src="https://github.com/Qincheng-Sheng/DC_motor_voltage_Inversion/blob/main/Picture/FFT_triangle.png" width="250" title="System">
</p>

Step 3.	Inverter the original voltage signal

<p align="center">
  <img src="https://github.com/Qincheng-Sheng/DC_motor_voltage_Inversion/blob/main/Picture/Inverted_sin.png" width="250" title="System">
  <img src="https://github.com/Qincheng-Sheng/DC_motor_voltage_Inversion/blob/main/Picture/Inverted_square.png" width="250" title="System">
  <img src="https://github.com/Qincheng-Sheng/DC_motor_voltage_Inversion/blob/main/Picture/Inverted_triangle.png" width="250" title="System">
</p>                                                                                                                                                      
