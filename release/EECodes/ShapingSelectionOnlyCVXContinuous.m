function [S,x,mup,mun,l1,l2,obj]=ShapingSelectionOnlyCVX(StateMat,B,alpha,w,sval,Avgbudget,cvec,regularizer,xub,xlb)

N=max(size(StateMat));
[~,Nc]=size(B);
q=1;
reg=0;

normK=20;
kv=ceil(normK*N/100);

cvx_begin quiet
    variables y(N,1) z(N,1) x(N,1) mup(N,1) mun(N,1) l1(N,1) l2(N,1) S(N,1)


     if sval==6
       minimize (norm_largest(y,kv)+regularizer*norm(S,1));
        end


     if sval==5
       minimize (norm_largest(y,kv)+regularizer*norm(S,1));
        
       end
    
     if sval==4
        minimize (-sum(z)+regularizer*norm(S,1));
     end
    
    if sval==3
    minimize (sum(z)+regularizer*norm(S,1));
    end

       
    if sval==2
     minimize (-min(z)+regularizer*norm(S,1));
    end

    if sval==1
     minimize (max(z)+regularizer*norm(S,1));
    end
    
subject to

StateMat*z+B*q*(l1-l2)+w*(1-S).*alpha==zeros(N,1);
%
cvec'*(l1+l2)<=Avgbudget*N;
%
min(0,xlb)<=z;
z<=xub;
%
xlb.*(1-S)<=z;
z<=xub.*(1-S);
%
x-S.*xub<=z;
z<=x-S.*xlb;
z<=x+S.*xub;
%
cvec.*l1<=Avgbudget*N*S;
cvec.*l2<=Avgbudget*N*S;
%
0<=l1<=mup;
0<=l2<=mun;
%
cvec.*mup-Avgbudget*(1-S)*N<=cvec.*l1;
cvec.*mun-Avgbudget*(1-S)*N<=cvec.*l2;
0<=S<=1;
%l1>=0;
%l2>=0;

if sval==5
y>=max(z,0);
end

if sval==6
y<=min(z,0);
end


 cvx_end
    
   obj=cvx_optval;

end
