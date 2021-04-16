function [] = dailyPrinter2021(calibrated,updateFolder,nodeID)

%  PRINTCSVDAILY Summary of this function goes here
%  Initially divides up all the timetable by day
%  then saves them as csv files for historic data
%  should have the appropriate naming convention
%  as the live daily csvs

timeZone  = "UTC";
latitudteCol  =  rmmissing(calibrated.Latitude);
longitudeCol  =  rmmissing(calibrated.Longitude);
calibratedFolder = updateFolder;

latitudeStringPre = sprintf('%0.8f',latitudteCol(end));
longitudeStringPre =sprintf('%0.8f',longitudeCol(end));
latitudeString = strcat(latitudeStringPre,"^o");
longitudeString =strcat(longitudeStringPre,"^o");

display("Printing complete time series for node: " +nodeID )

printCSVTTAll(calibrated,updateFolder,nodeID,timeZone)

display("Plotting complete time series for node: " +nodeID )


drawTimeSeries5xAll(...
    calibrated.dateTime,...
    calibrated.PM1,...
    calibrated.dateTime,...
    calibrated.PM2_5,...
    calibrated.dateTime,...
    calibrated.PM4,...
    calibrated.dateTime,...
    calibrated.PM10,...
    calibrated.dateTime,...
    calibrated.PMTotal,...
    "PM_{1}","PM_{2.5}","PM_{4}","PM_{10}","PM_{Total}",...
    nodeID,...
    strcat(timeZone," Time"),...
    "PM (\mug/m^{3})",...
    strcat("Particulate Matter (",latitudeString,",",longitudeString,")"),...
    calibratedFolder,...
    strcat("PM_",timeZone,"_Time"),...
    true,...
    100 ...
    )    ;


datesIn =  datetime('today','timezone','utc') -1 :-day(1): datetime(2017,1,1,'timezone','utc');

for dateIndex = 1: length(datesIn)
    try 
    currentDate =  datesIn(dateIndex) ;
    display("Printing files for Node: " +nodeID + " for " + string(currentDate) )
    
    predictedTable = calibrated(currentDate<=calibrated.dateTime & ...
        calibrated.dateTime<currentDate+1,:);
    
    % Get data for the current day
    if(height(predictedTable)>50)
        printCSVTT(predictedTable,updateFolder,nodeID,currentDate,'calibrated');
    end
    
    catch e
        display(e)
    end

    clearvars -except...
    calibrated dateIndex datesIn updateFolder nodeID
    
end

end

