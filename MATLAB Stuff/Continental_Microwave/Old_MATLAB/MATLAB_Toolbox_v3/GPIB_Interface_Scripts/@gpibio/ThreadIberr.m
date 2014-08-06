function iberr = ThreadIberr( gpib )
%THREADIBERR Updates the value of iberr

    gpib.ibsta.Value = calllib('gpib32', 'ThreadIberr');
    iberr = gpib.iberr.Value;
end
