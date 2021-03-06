function [ ljudObj, ljhandle ] = LED_initialize( ~ )
%%  Opens the connection to Labjack and returns its handles.
%   The function attempts to establish a connection with a LabJack. If it
%   finds any it will return the handles to the first one found.
    
%   Make the UD .NET assembly visible in MATLAB
    ljasm = NET.addAssembly('LJUDDotNet');
    ljudObj = LabJack.LabJackUD.LJUD;
    try
    %   Open the first found LabJack U3.
        [ljerror, ljhandle] = ljudObj.OpenLabJack(LabJack.LabJackUD.DEVICE.U3, LabJack.LabJackUD.CONNECTION.USB, '0', true, 0);
    %   Start by using the pin_configuration_reset IOType so that all pin assignments are in the factory default condition.
        ljudObj.ePut(ljhandle, LabJack.LabJackUD.IO.PIN_CONFIGURATION_RESET, 0, 0, 0);
        ljudObj.AddRequest(ljhandle, LabJack.LabJackUD.IO.GET_DIGITAL_BIT_STATE, 4, 0, 0, 0);
    %   Execute command
        ljudObj.GoOne(ljhandle);
        [~, ~, ~, dblValue, ~, dummyDbl] = ljudObj.GetFirstResult(ljhandle, 0, 0, 0, 0, 0);
        disp('LED OPEN');
    catch
        msg = ['Error while opening Labjack'];
        h = errordlg(msg);
    end
end

