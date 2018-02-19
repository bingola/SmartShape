function []=RunFileBenchMark(dataIndex,centIndx)
cd ../cvx
cvx_setup;
cd ../codes/;
budget=100;

graphTypeSet={'Twitter'};

w=[10 10 10 10 10 10 10];
normK=20;
for ix=dataIndex
    ix

     for cI=centIndx
            graphType=graphTypeSet{ix};
	    shapingSPBenchmark(graphType,cI,budget,w(ix));
	   
       end
       end
  
