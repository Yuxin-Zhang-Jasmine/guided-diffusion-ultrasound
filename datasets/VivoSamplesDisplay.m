 
%-------------------------------------------------------------------------%
% Imaging from the saved .h5 files                                                  
%-------------------------------------------------------------------------%
clear
clc
dataSaveDir = 'data_save2_(both4000)/'; % data_save1_(vitro6000) | data_save2_(both4000)
count = 1;
load('spaceGrid.mat')

h = figure; 

tiledlayout(12,11, "TileSpacing","none","Padding","none", InnerPosition=[0,0,1,1])

for dataName = ["CAROTID1", "CAROTID2", "CAROTID3", "CAROTID4", "CAROTID5", "CAROTID6", ...
        "CAROTIDlong1", "CAROTIDlong2", "CAROTIDlong3", "CAROTIDlong4", "CAROTIDlong5","CAROTIDlong6"]
for idx = 1: 10: 101
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
