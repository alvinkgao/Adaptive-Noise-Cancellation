# Adaptive Noise Cancellation 

This is the matlab code for implementations of LMS (least mean square), RLS (recursive least squares), and LMS where L > 1.

# To run

1. You must have Matlab with the DSP systems toolbox installed.
2. Open hw3data.mat
3. Type the following commands:  
   h = [0.78 -.55 0.24 -0.16 0.08];  
   fnoise = conv(noise,h);  
   primary = voice + 100*fnoise(1:660000);  
   [errl,errr,err2] = anc(100*noise,primary,0.0000005,5,25,600000);  
  
# To play sounds
   sound(errl,22000)
