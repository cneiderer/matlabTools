function ibsta = ThreadIbsta( gpib )
%THREADIBSTA Updates the value of ibsta

    gpib.ibsta.Value = calllib('gpib32', 'ThreadIbsta');
    ibsta = gpib.ibsta.Value;
end
