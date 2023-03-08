function [BandSet,Time]=SelectBand_OPBS2(y,n)
%opbs 2 is faster than opbs3
% BandSet: the selected band set 
% x: an L*N dimensional dataset, each row is a band 
% BandNum: number of the bands to be selected
tic;
[~,L]=size(y);            % get the numbers of bands and pixels

id0=zeros(1,n);        % id is the index of the selected bands

for i=1:L
    y(:,i)=y(:,i)-mean(y(:,i));              % mean-shift/mean reduction
end

% Initialization:
h=zeros(1,L);
for t=1:L
    yt=y(:,t);
    h(t)=yt'*yt;
end

[hid,id]=max(h);
id0(1)=id;
 
% Band selection
for i=2:n
   yid=y(:,id);
   x=yid'*y/hid;
   for t=1:L
        if ismember(id0,t)
             h(t)=0;
            continue
        end
       y(:,t)=y(:,t)-yid*x(t);
       yt=y(:,t);
       h(t)=yt'*yt;
   end
   [hid,id]=max(h);
   id0(i)=id;
end
 
BandSet=sort(id0);

Time=toc;
