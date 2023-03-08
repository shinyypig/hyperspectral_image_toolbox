function  [Bands,time] =  EFDPC(x,k)
% Input the original image
% HSI = indian_pines(:,:,[4:102,113:147,166:216]);

%%% change 1: Pre_Process For Band Selection%%%
% load('Indiana185_Ref.mat');
tic;
Nb=size(x,1);
for i=1:Nb
    if max(x(i,:))~=min(x(i,:))
        x(i,:)= (x(i,:)-min(x(i,:)))/(max(x(i,:))-min(x(i,:)));
        %         x(i,:)=(x(i,:)-mean(x(i,:)))/(std(x(i,:)));
    else
        x(i,:)=0;
    end
end
% Img = reshape(x',[Lines,Columns,L]);%%%Lines：145 Columns：145 L:185

%%%%%%%%%
% Img = (HSI);
% [Nr, Nc, Nb] = size(Img);
% Compute the distance between two band images
Img_matrix = x';%reshape(Img,Nr*Nc,Nb);
Dist_matrix = zeros(Nb,Nb);
for i=1:Nb-1
    Vi = Img_matrix(:,i);
    for j = i+1:Nb
        Vj =Img_matrix(:,j);
        Vi = Vi(:);
        Vj = Vj(:);
        Dist_matrix(i,j) = norm((Vi-Vj),2);
        Dist_matrix(j,i) = Dist_matrix(i,j);
    end
end
Dist_matrix = Dist_matrix/Nb;
% Compute dc value
percent=2.0;
%position=round(Nb*(Nb-1)/2*(100-percent)/100);

%%%%%%change 2: Here should be %2 percent
position=round(Nb*(Nb-1)/2*percent/100);

% sda=sort(Dist_matrix(:),'descend'); 
%%%% change 3: Here should be the tril(Dist_matrix) and the order should be ascend 
temp = Dist_matrix(find(tril(Dist_matrix)~=0));
sda = sort(temp);
%%%%%
if position == 0 
    position=1;
end
dini=sda(position);
% k = 10;
dc = dini/exp(k/Nb);
% Compute the rho factor
rho = zeros(Nb,1);
for i = 1:Nb
    for j = 1:Nb
        if i~=j
            rho(i) =rho(i)+ exp(-(Dist_matrix(i,j)/dc)^2);
        end
    end
end
% Compute the delta factor
[~,ordrho]=sort(rho,'descend');
% maxd=max(max(Dist_matrix(ordrho(1),:)));
delta = zeros(Nb,1);
delta(ordrho(1))=-1;               %density is the most
maxD = max(max(Dist_matrix));
for i = 2:Nb
    delta(ordrho(i))=maxD;
    for j=1:i-1
        if Dist_matrix(ordrho(i),ordrho(j))<delta(ordrho(i))
            delta(ordrho(i)) = Dist_matrix(ordrho(i),ordrho(j));
        end
    end
end
delta(ordrho(1)) = max(delta);
% normalize the factors
rho = (rho-min(rho(:)))/(max(rho(:))-min(rho(:)));
delta = (delta-min(delta(:)))/(max(delta(:))-min(delta(:)));
% The final importance
gamma =rho.*delta.*delta;
% Find the selected bands
[~,order_band] = sort(gamma,'descend');
Bands = order_band(1:k)';

time=toc;
%补充：因为是对去除低信噪比后的185个波段数据，程序中的x为原始光谱数据的变形，维度为185*21025


end

