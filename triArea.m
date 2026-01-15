function area=triArea(p1,p2,p3)
% p1,p2,p3分别表示三角形三个点的坐标
area=1/2*norm(cross(p2-p1,p3-p1));