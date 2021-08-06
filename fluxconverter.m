% octave code that converts .flux files to .csv files
% opens a window that allows the user to select one or multiple .flux files for conversion
% this is the preferred version of the code given that octave is free

% file selection window
[file,path] = uigetfile('*.flux','MultiSelect','on');
if class(file) == 'char'
    amnt = 1;
else
    amnt = length(file);
endif

% iterating through each selected file
for m=1:amnt
    % changing the file extension to .csv while keeping the same name
    % loading all the data from the .flux file
    if class(file) == 'char'
        csvfile = strcat(file(1:end-5),".csv");
        file = strcat(path,file);
        data = loadFluxFileSignal(file,1);
    else
        csvfile = strcat(file{m}(1:end-5),".csv");
        file{m} = strcat(path,file{m});
        data = loadFluxFileSignal(file{m},1);
    endif
    
    % separating and reshaping the .flux file data
    F = transpose(data.F);
    V = transpose(data.V);
    Paw = transpose(data.Paw);
    Pes = transpose(data.Pes);
    Pgas = transpose(data.Pgas);
    CO2 = transpose(data.CO2);
    Time = transpose(data.Time);
    Ptpulm = transpose(data.Ptpulm);
    Ptdiaf = transpose(data.Ptdiaf);
    V2 = transpose(data.V2);
    
    len = length(F);

    % opening and writing the data to a csv file
    fid = fopen(csvfile, "w");
    
    fprintf(fid,'%s\n',"FluxView - FluxMed acquisition system")
    fprintf(fid,'%s\n',"Signal file")
    fprintf(fid,'%s, %f\n',"Serial Number:", data.header.serialNumber)
    fprintf(fid,'%s, %f, %s, %f\n',"SW version:", data.header.softwareVersion, "File version:", data.header.fileVersion)
    fprintf(fid,'%s, %s\n',"Sampling rate:", "256 Hz")
    fprintf(fid,'%s, %s, %s, %s, %s, %s, %s, %s, %s\n',"Time", "Flow", "Volume", "Paw", "Pes", "Ptpulm", "Pga", "Ptdiaf", "CO2")
    fprintf(fid,'%s, %s, %s, %s, %s, %s, %s, %s, %s\n',"Sec", "l/min", "ml", "cmH2O", "cmH2O", "cmH2O", "cmH2O", "cmH2O", "mmHg")
    
    for n=1:len
        % appending the data row by row
        csvwrite(fid,[Time(n),F(n),V2(n),Paw(n),Pes(n),Ptpulm(n),Pgas(n),Ptdiaf(n),CO2(n)],'-append');  
    endfor
    
    fclose(fid);
endfor
