%% 3D model bound box
%% by h005
function [vt,xRange,yRange,zRange] = boxModel(model)
% ref http://blog.csdn.net/bugrunner/article/details/5468570
% vertex corrdinate
% vt = load('kxm.v');
vt = load([model,'.v']);
% face index
fe = load([model,'.f']);
% Translation Invariance
c = sum(vt) / size(vt,1);
vt(:,1) = vt(:,1) - c(1);
vt(:,2) = vt(:,2) - c(2);
vt(:,3) = vt(:,3) - c(3);
area = triangleArea(fe);

M = zeros(3,3);

for i=1:size(vt,1)
    M = M + vt(i,:)' * vt(i,:);
end
    
M = M / area;

[V,D] = eig(M);

eigV = diag(V);

[eigV,index] = sort(eigV,'descend');

RM = zeros(size(D,1),size(D,2));

for i=1:length(index)
    RM(:,i) = D(:,index(i));
end

vt = RM * vt';
%% get RM then rotate done

disp(area);

%% draw the model
figure
for i=1:size(fe,1)
    hold on
    fill3(vt(1,fe(i,:)+1),vt(2,fe(i,:)+1),vt(3,fe(i,:)+1),'b');
end

%% get round box
xRange = [min(vt(1,:)),max(vt(1,:))];
yRange = [min(vt(2,:)),max(vt(2,:))];
zRange = [min(vt(3,:)),max(vt(3,:))];

box = zeros(3,8);
index = 1;
for i=1:2
    for j=1:2
        for k = 1:2
            box(:,index) = [xRange(i);yRange(j);zRange(k)];
            index = index + 1;
        end
    end
end

% hold on
% plot3(box(1,:),box(2,:),box(3,:),'ro')

lineIndex = [0,4;1,5;3,7;2,6;0,2;4,6;1,3;5,7;0,1;4,5;6,7;2,3];
lineIndex = lineIndex + 1;
for i=1:size(lineIndex,1)
    hold on
    if i<5
        plot3(box(1,lineIndex(i,:)),box(2,lineIndex(i,:)),box(3,lineIndex(i,:)),'r-');
    elseif i>=5 && i < 9
        plot3(box(1,lineIndex(i,:)),box(2,lineIndex(i,:)),box(3,lineIndex(i,:)),'g-');
    elseif i>=9
        plot3(box(1,lineIndex(i,:)),box(2,lineIndex(i,:)),box(3,lineIndex(i,:)),'m-');
    end
%     plot3([box(1,lineIndex(i,1));box(1,lineIndex(i,2))],[box(2,lineIndex(i,1));box(2,lineIndex(i,2))],'r')
end



function area = triangleArea(face)
    area = 0;
    for i=1:size(face,1)
        % edge A B
        AB = -(vt(face(i,1)+1,:) - vt(face(i,2)+1,:));
        a = norm(AB);
        % edge B C
        BC = -vt(face(i,2)+1,:) + vt(face(i,3)+1,:);
        b = norm(BC);
        % edge C A
        AC = vt(face(i,3)+1,:) - vt(face(i,1)+1,:);
        c = norm(AC);
        s = (a + b + c)/2;
        area = area + sqrt(s*(s-a)*(s-b)*(s-c));       
    end
end
end