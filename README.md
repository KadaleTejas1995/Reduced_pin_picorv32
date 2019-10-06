Hello ENGR - 852 students 

This repository is a contribution of : 
Dr Hamid Mahmoodi ,
Tejas Kadale  and other researchers in NECRL in SCI 110

To use this repository for your project : 

Download or clone the repository on your desktop

Use picorv32_reducedpin.v as your RTL for the project 
Upload all testbench files and RTL on the server in "vcs" folder  : Enter  cd asic_flow_setup/vcs

Upload all the files using the GUI on the left in mobaxterm or directly drag in the folders using Filezilla 
Once you have uploaded the files ,run the three testbenches one by one  ; Refer the sample command below to run your testbench with the RTL 

ex : vcs -V -R testbench_RS.v picorv32_reducedpin.v -debug_pp  -full64 

Do this for other two files. The command will show the write memory location and memory value and also the instruction executed when memory is written (wstrb 1111)  . Check if there is any error showing in the terminal , if present please report .
You can also view and edit the testbenches as you like and can include more operations in the testbench , to do this you need to edit the initial program memory 

The above command would generate files required to view the RTL simulation in DVE 

To run DVE : dve -full64

Open DVE and open the .dump file 

Select the testbench module and view all the waveform 
Follow the ASIC tutorial file for detailed guide

Once all the testbenched have passed , goto DC synthesis section 
Make sure you are using correct file paths while using DC Synthesis. 

If any changes or error found , I will update this repository

Thank you and All the Best  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

