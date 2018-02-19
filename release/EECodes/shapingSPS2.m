function []=shapingSPS2(graphType,cenOption,budget,w)
 
FILE=strcat('../data/',graphType,'_ShapingPreProccessed');


load(FILE);
ss=0;
graph=graphout;
A=graph.A;
N=max(size(A));
mu=graph.mu;
alpha=graph.alpha;
graphout=graph;

pp=0;
SMAll=A'*diag(mu)-w*eye(N);
xinf=-inv(SMAll)*w*alpha';
xinf=xinf.*(1+0.1*rand(N,1));

for centrality=cenOption

regIndex=centrality;

FILE=strcat('../data/',graphType,'_selectNodes_NonLinearized_',num2str(regIndex),'XRawSelNodes');  
 
load(FILE)
graphx=graphout;
clear graphout;
for sval=1:6
centralityMeasure=graphx.S(:,sval);
pr=centralityMeasure;

    ss=0;
    pp=pp+1;

%    clear x
%    clear l1
%    clear l2
%    clear obj
%    clear vvec
%    clear Ncvec
     
for ks=[1 10 20 40 50];
%top k nodes
ss=ss+1;
k=floor(N*ks/100);
[x1,x2]=sort(pr,'descend');
Nc=x2(1:k);
cvec=ones(k,1);

StateMat=A;
v=setdiff(1:N,Nc);
StateMat=StateMat(v,v)';
B=A(Nc,v)';
SM=StateMat*diag(mu(v))-w*eye(length(v));
ll=max(real(eig(SM)));
xin=xinf(v);
alp=alpha(v)'; 

[xx1 lx1 lx2 objx1,NewObjx]=shapeOpinion(SM,B,alp,w,sval,xin,budget,cvec);
 x{ss}(:,sval)=xx1;
l1{ss}(:,sval)=lx1;
l2{ss}(:,sval)=lx2;
obj(ss,sval)=objx1;
NewObj(ss,sval)=NewObjx;

llx(ss)=ll;
vvec{ss}=v;
Ncvec{ss}=Nc;
end
end
end
%graphoutS=graphout;
graphoutS.N=vvec;
graphoutS.Nc=Ncvec;
graphoutS.x=x;
graphoutS.l1=l1;
graphoutS.l2=l2;
graphoutS.obj=obj;
graphoutS.newObj=NewObj;
graphoutS.llx=llx;
graphoutS.budget=budget;

 
FILE=strcat('../data/',graphType,'_SelX_',num2str(cenOption),'_',num2str(100*budget),'_GraphShapeParamsAvg');
eval(['save ',FILE,' graphoutS;']);
end
