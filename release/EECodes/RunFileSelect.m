function []=RunFileSelect(dataIndex,regV)

addpath('/home/ade/mosek/7/toolbox/r2013a');
cd ../cvx/
cvx_setup 
cd ../codesNew/



graphTypeSet={'Twitter'};


w=[10 10 10 10 10 10 10];
for ix=dataIndex
    ix
	for regIndex=regV
		budget=100;
        	graphType=graphTypeSet{ix};
		FuncSelectNodesReal(graphType,regIndex,budget,w(ix)); 		
		shapingSPS2(graphType,regIndex,budget,w(ix));
	end
    
end
end
