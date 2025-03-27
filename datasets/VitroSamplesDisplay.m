 
%-------------------------------------------------------------------------%
% Imaging from the saved .h5 files                                                  
%-------------------------------------------------------------------------%
clear
clc
dataSaveDir = 'data_save1_(vitro6000)/'; % data_save1_(vitro6000) | data_save2_(both4000)
count = 1;
load('spaceGrid.mat')

h = figure; 

tiledlayout(8,11, "TileSpacing","none","Padding","none", InnerPosition=[0,0,1,1])

for dataName = ["CIRS11", "CIRS12", "CIRS13", "CIRS14", ...
        "CIRS15", "CIRS16", "CIRS17", "CIRS18"] 
for idx = 1: 10: 103
    dataSaveName = append(dataSaveDir,dataName, '_', num2str(idx),'.h5');
    O_PWI = h5read(dataSaveName,"/data");

    % Envelope and log compression %
    % O_PWI = abs(hilbert(O_PWI));  
    O_PWI = abs((O_PWI));  
    O_PWI  = 20*log10(O_PWI./max(abs(O_PWI(:))));  
    
    % Plot %
    nexttile;
    imagesc(spaceGrid.x, spaceGrid.z,O_PWI)
    
%     title(['DAS image ' num2str(count)])
%     xlabel('x (mm)')
%     ylabel('z (mm)')
     axis equal
    % colorbar
     colormap('gray'); caxis([-60,0])
    % set(gca,'Fontsize',8);
    axis([[spaceGrid.Xmin spaceGrid.Xmax] [spaceGrid.Zmin spaceGrid.Zmax]])
    axis off
    count = count + 1;
end

end
