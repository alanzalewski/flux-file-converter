% matlab code that converts .flux files to .xlsx files
% opens a window that allows the user to select one or multiple .flux files for conversion

% file selection window
[file,path] = uigetfile('*.flux','MultiSelect','on');
if class(file) == 'char'
    amnt = 1;
else
    amnt = length(file);
end

% iterating through each selected file
for i=1:amnt

    % changing the file extension while keeping the same name
    % loading all the data from the .flux file
    if class(file) == 'char'
        xlsxfile = strcat(file(1:end-5),".xlsx");
        file = strcat(path,file);
        data = loadFluxFileSignal(file,1);
    else
        xlsxfile = strcat(file{i}(1:end-5),".xlsx");
        file{i} = strcat(path,file{i});
        data = loadFluxFileSignal(file{i},1);
    end
    
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
    len = string(length(F)+8);
    header = {["FluxView - FluxMed acquisition system"], ["Signal file"], ["Serial Number:" data.header.serialNumber], ["SW version:" data.header.softwareVersion "File version:" data.header.fileVersion], ["Sampling rate:" "256 Hz"], ["Time" "Flow" "Volume" "Paw" "Pes" "Ptpulm" "Pga" "Ptdiaf" "CO2"], ["Sec" "l/min" "ml" "cmH2O" "cmH2O" "cmH2O" "cmH2O" "cmH2O" "mmHg"]};

    % writing the data to an excel matrix
    writematrix(header{1},xlsxfile,'Sheet',1,'Range','A1');
    writematrix(header{2},xlsxfile,'Sheet',1,'Range','A2');
    writematrix(header{3},xlsxfile,'Sheet',1,'Range','A3:B3');
    writematrix(header{4},xlsxfile,'Sheet',1,'Range','A4:D4');
    writematrix(header{5},xlsxfile,'Sheet',1,'Range','A5:B5');
    writematrix(header{6},xlsxfile,'Sheet',1,'Range','A6:I6');
    writematrix(header{7},xlsxfile,'Sheet',1,'Range','A7:I7');
    writematrix(Time,xlsxfile,'Sheet',1,'Range','A8:A'+len); 
    writematrix(F,xlsxfile,'Sheet',1,'Range','B8:B'+len);
    writematrix(V2,xlsxfile,'Sheet',1,'Range','C8:C'+len);
    writematrix(Paw,xlsxfile,'Sheet',1,'Range','D8:D'+len);
    writematrix(Pes,xlsxfile,'Sheet',1,'Range','E8:E'+len);
    writematrix(Ptpulm,xlsxfile,'Sheet',1,'Range','F8:F'+len);
    writematrix(Pgas,xlsxfile,'Sheet',1,'Range','G8:G'+len);
    writematrix(Ptdiaf,xlsxfile,'Sheet',1,'Range','H8:H'+len);
    writematrix(CO2,xlsxfile,'Sheet',1,'Range','I8:I'+len);
end


