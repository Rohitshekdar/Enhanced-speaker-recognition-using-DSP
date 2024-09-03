clc;
clear;
close all;
%% create arecorder object
recorder=audiorecorder(16000,16,2);
%% Record user's voice for 5 seconds
disp('please record your voice');
drawnow();%%updates the figure and the callbacks 
pause(1);%% pause the process and then display the graph
recordblocking(recorder,5); %%records the audio for 5 seconds
play(recorder);%%runs the audio data
data=getaudiodata(recorder); %% stores a double array in the var data
plot(data);
xlabel('time');
ylabel('Amplitude');
figure;%% plots two different plots at the same time   
f= voice_feature(data); 
%% save users data
uno = input('Enter your user number: ');

try 
    load database
    

    F=[F;f];%%update the frequency array
    C=[C;uno];%% updates the user number to C array
    save database F C
catch
    F=f;%% if any error occurs the latest values are updated to array
    C=uno;
    save database F C
end
msgbox('Your voice is registered')%% GUI to display the message 