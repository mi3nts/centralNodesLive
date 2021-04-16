function [] = dailyTSPlotter2021(calibrated,updateFolder,nodeID)


datesIn =  datetime('today','timezone','utc') -1 :-day(1): datetime(2017,1,1,'timezone','utc');

for dateIndex = 1: length(datesIn)
    try
        currentDate =  datesIn(dateIndex) ;
        display("Ploting Time Series for Node: " +nodeID + " for " + string(currentDate) )
        
        predictedTable = calibrated(currentDate<=calibrated.dateTime & ...
            calibrated.dateTime<currentDate+1,:);
        
        % Get data for the current day
        if(height(predictedTable)>50)
    
            timeSeriesPlotsTLL(predictedTable,...
                nodeID,...
                currentDate,...
                updateFolder,...
                "UTC");
        end
        
    catch e
        display(e)
    end
    
    clearvars -global -except...
        calibrated dateIndex datesIn updateFolder nodeID
    
    
end

end

