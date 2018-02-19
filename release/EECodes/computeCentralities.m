clc
clear all
DatasetSet={'Twitter'};
addpath('/home/abir/cvx');
addpath('/home/abir/pagerank-1.2');
addpath('/home/abir/matlabNet');
w1=1;
for cenOption=1
 for ix=7 %datasetID
  for centrality=[1:4 6]
     ix
 Dataset=DatasetSet{ix};
 FILE=strcat('../data/',Dataset,'_',num2str(101),'ALLXContainedOpinionX');
load(FILE);
eval(['Ahat=graph.AhatOpinion',num2str(w1+1),';']);


if cenOption==1
TargetMat=(Ahat);
end

if cenOption==2
TargetMat=abs(Ahat);
end

if cenOption==3
TargetMat=(graph.Adj);
end


if centrality==1
[pr]=pagerank(TargetMat);
end
if centrality==2
 [pr]=sum(TargetMat)';
end

if centrality==3
 [pr]=sum(TargetMat');
end
% closeness.m - computes the closeness centrality for all vertices;
% node_betweenness.m - node betweenness, (number of shortest paths definition);
% node_betweenness.m - a faster node betweenness algorithm;
% edge_betweenness.m - edge betweenness, (number of shortest paths definition);
% eigencentrality.m

if centrality==4
[pr]=closeness(TargetMat);
end

% if centrality==5
% [pr]=betweenness_wei(TargetMat);
% end

if centrality==6
[pr]=eigencentrality(TargetMat);
end

    centralityMeasure=pr;
    FILE=strcat('../data/',Dataset,'_',num2str(centrality),'_',num2str(cenOption),'_Centralities');
    eval(['save ',FILE,' centralityMeasure;']);
   end
  end
end
