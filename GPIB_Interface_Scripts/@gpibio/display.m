function display(gpib)
% display - prints the properties of gpibio object

    disp(' ');
    disp([inputname(1),' = '])
    disp(sprintf('%s%i', '    ibcnt: ', gpib.ibcnt.Value))
    disp(sprintf('%s%i','    ibsta: ' , gpib.ibsta.Value))
    disp(sprintf('%s%i','    iberr: ' , gpib.iberr.Value))
    disp(sprintf('%s%i','  timeout: ', gpib.timeout.Value))
end