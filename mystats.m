clear 
clc
close all
tic
x = '1 石头 2 剪刀 3 布 : '

a = input(x);

if a <= 3
    b = randi([1,3]);
    judge = [a b];
else
    disp('wrong')
end

if isequal(judge(1,1),judge(1,2))
    disp('平局')
elseif (judge(1,1) == 1) && (judge(1,2) == 3)
    disp("lose")
elseif (judge(1,1) == 3) && (judge(1,2) == 1)
    disp('win')

elseif judge(1,1) < judge(1,2)
    disp('win')
else judge(1,1)  > judge(1,2)
    disp("lose")


end

toc
   

















