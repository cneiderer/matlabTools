function ibsta = ibdma (gpib,ud, dma)
%ibdma -- Enables/Disables DMA
%   ibsta = ibdma (ud, dma)
% board is an integer containing the board handle.
% dma is an integer which indicates whether DMA is to be enabled or 
%disabled for the specified GPIB board. If dma is non-zero, then all read 
%and write operations between the GPIB board and memory will be performed 
%using DMA. Otherwise, programmed I/O will be used.

ibsta = calllib('gpib32', 'ibdma', ud, dma);
gpib.ibsta.Value = ibsta;
end