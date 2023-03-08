function [Band,time]=ECA(x,n)

%% ======About ECA====== %%
% Kang Sun, Xiurui Geng, Luyan Ji. "Exemplar component analysis: a fast 
% band selection method for hyperspectral imagery", IEEE Geoscience and 
% Remote Sensing Letters. 2015, 12(5):998-1002.

% Author: Kang Sun, Dec. 2014
% For public release
% All rights reserved
%% ======Input variables====== %%
% x, The 2-D hyperspectral image with size L*N, where 
%     L is the number of total bands, N is the number of pixels
% n,  the number of selected bands. 

%% ======Output variables====== %%
% Band, the selected band numbers
%% =============ECA============ %%
tic;
[L,N]=size(x);%L is the number of total bands, N is the number of pixels
%% =======Compute distance Matrix====== %%
R=x*x';
Temp=diag(R)*ones(1,L);
D=sqrt(Temp+Temp'-2*abs(R));%Distance matrix

%% ======Compute rho======%%
sigma=mean(mean(D))/0.1;%parameter sigma,can be modified for different datasets
% sigma=mean(mean(D))/30;  
W=exp(-(D./sigma));
W=W;
rho=sum(W,2);%rho, measuring the local density

%% ======Compute delta====== %%
delta=zeros(L,1);
[~,Ind1]=max(rho);
for i=1:L    
    if(i~=Ind1)
        Ind= rho>rho(i);
        TempD=D(Ind,i);
        delta(i)=min(TempD);
    end
end
delta(Ind1)=mean(delta);

%% ======Cumpute ES====== %%
ES=rho.*delta; %Exemplar socre defined in the paper
[Value,Ind]=sort(ES,'descend');%Sort the ES in descending order, Value is 
                               % the sorted values, Ind the according
                               % orders
Band=Ind(1:n);% the top n bands is final result
Band=sort(Band);
time=toc;