function [var_x,var_y,var_z] =create_trajectory()

data = load('dog_data.mat').data;
l1a = 0.07875;
l1b = 0.11;
l2 = 0.3;
l3 = 0.3;

time = data(7:560 , 2)*20;

X_p = data(7:560 , 36).';

Y_p = data(7:560 , 37).';

Z_p = data(7:560 , 38).';
%Now take 3 points on the dog body
X_LFW = data(7:560 , 60);
Y_LFW = data(7:560 , 61);
Z_LFW = data(7:560 , 62);

X_RFW = data(7:560 , 63);
Y_RFW = data(7:560 , 64);
Z_RFW = data(7:560 , 65);

%This will be the origin of our RF
X_LBW = data(7:560 , 66);
Y_LBW = data(7:560 , 67);
Z_LBW = data(7:560 , 68);


figure; plot(Y_LBW/1000 + 4, Z_LBW*4/1000 - 1.4 , 'LineWidth',1); xlim([0 , 8]);  xlabel('X direction[m]'); ylabel('Z direction[m]')
title('Dog toe trajectory w.r.t. camera reference frame');

T = [X_LBW , Y_LBW , Z_LBW].'; %series of translation vectors
a = [X_LFW , Y_LFW , Z_LFW];
b = [X_LBW , Y_LBW , Z_LBW];
c = [X_RFW , Y_RFW , Z_RFW];

x = (a - b).';
y_raw = (c - a).';
z = [];
y = [];
point_traj = [];

for i=1:554
    %generate a vector which will be for sure normal to x
    temp = cross(x(:,i) , y_raw(:,i));
    temp = temp / norm(temp); 
    z = [z , temp];


    %now generate the new y normal to x and z
    y_temp = cross(z(:,i),x(:,i));
    y_temp = y_temp / norm(y_temp); 
    y = [y , y_temp];

    R = [x(:,i)/norm(x(:,i)) , y_temp , temp];

    %det(R)
    M_temp = [R , T(:,i);
        0 0 0 1];

    det(M_temp);

    M = inv(M_temp);

    point_traj = [point_traj , M * ([X_p(i) ; Y_p(i) ; Z_p(i) ; 1])-[0.7 0 0 0].'];

end

var_x.time = time(400:490) - 133;
var_x.signals(1).values = flipud(point_traj(1,400:490).' / 2000 - 0.2);

var_y.time = time(400:490) - 133;
var_y.signals(1).values = point_traj(2,400:490).' / 5000;

var_z.time = time(400:490) - 133;
var_z.signals(1).values = flipud(-point_traj(3,400:490).' / 1000 + 0.0);

%open('IJ_right_model_REAL.slx');
%sim('IJ_right_model_REAL.slx');


figure;
plot(var_x.signals(1).values, var_z.signals(1).values); xlabel('X direction[m]'); ylabel('Z direction[m]')
title('Dog toe trajectory represented w.r.t. the robot body reference frame');
var_x=var_x.signals(1).values;
var_y=var_y.signals(1).values;
var_z=var_z.signals(1).values;

end