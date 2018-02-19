function [x l1 l2 obj NewObj]=shapeOpinion(StateMat,B,alphaAgents,w,sval,xinf,Avgbudget,cvec)
N=max(size(StateMat));
[~,Nc]=size(B);
q=1;
reg=0;
normK=20;
kv=ceil(normK*N/100);
cvx_begin quiet
    variables y(N,1) x(N,1) l1(Nc,1) l2(Nc,1)


     if sval==6
       minimize (norm_largest(y,kv))
        end


     if sval==5
       minimize (norm_largest(y,kv))
	
       end
    
     if sval==4
        minimize (-sum(x));
     end
    
    if sval==3
    minimize (sum(x));
    end
    
    if sval==2
     minimize (-min(x));
    end
    if sval==1
     minimize (max(x));
    end
    
subject to
% size(StateMat)
% size(x)
% size(B)
% size(l)
% size(alphaAgents)
% N
StateMat*x+B*q*(l1-l2)+w*alphaAgents==zeros(N,1);
cvec'*(l1+l2)<=Avgbudget*Nc;
l1>=0;
l2>=0;

if sval==5
y>=max(x,0);
end

if sval==6
y<=min(x,0);
end

 cvx_end
x_effect=[x;q*(l1-l2)./(l1+l2)];
if sval==1
NewObj=max([x_effect]);
end

if sval==2
NewObj=-min([x_effect]);
end

if sval==3
NewObj=sum([x_effect]);
end

if sval==4
NewObj=-sum([x_effect]);
end


if sval==5
NewObj=norm_largest([x_effect],kv);
end

if sval==6
NewObj=norm_largest([x_effect],kv);
end



obj=cvx_optval;
end 
