
#for i in {1,2,3,5,6}
for i in 1
do 
for j in {1,2,3,4,5}
do


nohup matlab -nojvm -nodisplay -r "RunFileSelect($i,$j)"> driver"$i".log &

done
done
