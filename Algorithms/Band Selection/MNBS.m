function Band = MNBS(data, n)
%% ======About MNBS====== %%
% Kang Sun, Xiurui Geng, Luyan Ji and Yun Lu. "A New Band Selection Method
% for Hyperspectral Image Based on Data Quality", Selected Topics in 
% Applied Earth Observations and Remote Sensing, IEEE Journal of, 2014

% Author: Kang Sun, Aug. 2014 
% This is the FAST implementation version.
% All rights reserved
%% ======Input variables====== %%
% data, The 3-D hyperspectral image with size Samples*Lines*Bands, where 
%       Samples is the number of rows, Lines is the number of lines and
%       Bands is the number of bands.
% n,    the number of selected bands. 

%% ======Output variables====== %%
% Band, the selected band numbers

    %% ======Initialization====== %%
    [rw,cl,L]=size(data);
    Z=zeros(rw-1,cl-1,L);%% noise

    %% ======Noise estimation: by shift difference======%%
    for i=1:L
        Z(:,:,i)=(2*data(1:rw-1,1:cl-1,i)-data(2:rw,1:cl-1,i)-data(1:rw-1,2:cl,i));
    end
    Z=Z./2;

    %% ======Covariance matrix for raw data and noise======%%
    Noise_Cov=cov(reshape(Z,(rw-1)*(cl-1),L));%% covariance matrix for noise
    Data_cov=cov(reshape(data,rw*cl,L));%% covariance matrix for raw data

    %% ======Main loop====== %%
    Band=1:L;
    for k=n+1:L
        index=Cal_Det(Data_cov,Noise_Cov);%% determine the band to be deleted
        Band(index)=[];%% delete band
        Data_cov(index,:)=[];Data_cov(:,index)=[];%% update data covariance
        Noise_Cov(index,:)=[];Noise_Cov(:,index)=[];%% update noise covariance
    end

end

%% ======Find the band to be deleted (FAST VERSION)====== %%
function ind=Cal_Det(K1,K2)
    InvK1=inv(K1);
    InvK2=inv(K2);
    DET=diag(InvK1)./diag(InvK2);
    [~,ind]=max(abs(DET));
end