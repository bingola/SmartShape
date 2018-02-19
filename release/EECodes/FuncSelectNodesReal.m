function []=FuncSelectNodesReal(graphType,regIndex,budget,w)

regularizerV=(1e-3)*[0.1 0.3 0.9 2.7 1 3 9 27 81];
regularizer=regularizerV(regIndex);
%FILE=strcat('../data/',graphType,'512Graph');
FILE=strcat('../data/',graphType,'_ShapingPreProccessed');

load(FILE)
graph=graphout;
A=graph.A;
mu=graph.mu;
N=max(size(A));

SMAll=A'*diag(mu)-w*eye(N);    
 
cvec=ones(N,1);
alpha=graph.alpha';
A=graph.A';


xub=-w*inv(SMAll)*alpha*(1)+100;
xlb=-w*inv(SMAll)*alpha-100;

clear graphout;

for sval=1:6
[Sc,xc,mupc,munc,l1c,l2c,objActualc]=ShapingSelectionOnlyCVXContinuous(SMAll,A,alpha,w,sval,budget,cvec,regularizer,xub,xlb);


graphout.x(:,sval)=xc;
graphout.S(:,sval)=Sc;
graphout.mup(:,sval)=mupc;
graphout.mun(:,sval)=munc;
graphout.objActual(:,sval)=objActualc;
graphout.regularizer(:,sval)=regularizer;
graphout.l1(:,sval)=l1c;
graphout.l2(:,sval)=l2c;
end
FILE=strcat('../data/',graphType,'_selectNodes_NonLinearized_',num2str(regIndex),'XRawSelNodes');


eval(['save ',FILE,' graphout;']);

end
