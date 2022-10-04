%clc
%clear all
%close all
% when using this function, put 2 times the number of zones as input
function [y_pos_offset,r,incident_ex,fm,min_cut] = f_zonal_plate_construction(lambda,m,h_zone,r_max)

    %fm = 6; % microns
    %lambda = 0.179; % microns: longitudinal wave speed/signal frequency
    %m=36; % plase put even number as it is symmetric on both sides
    %h_zone = 0.050;
    %r_max = sqrt(fm*lambda*m/2)
    %r_max= 4.3666
    fm = ((r_max^2)/((m/2)*lambda)) - ((m/2)*lambda/4);%-((m/2)*lambda/4)
    

%*Negative Zonal Plate*

    
    for i=1:m/2
        r(i) = r_max-sqrt(fm*lambda*(m/2-(i-1)));
        zone_number = (m/2)-(i-1);
        if mod(zone_number,2) == 0
            y(2*i-1,:)=[r(i),0];
            y(2*i,:)=[r(i),h_zone];        
        else
            y(2*i-1,:)=[r(i),h_zone];
            y(2*i,:)=[r(i),0];       
        
        end
        
        if i==m/2
            y(2*i+1,:) = [r_max,0];
        end
        
    end
    
%     figure;
%     plot(y(:,1),y(:,2));
%     grid on;
%     ylim([-0.0500 0.2000]);

%*Positive Zonal Plate*

    N = m/2;
%     y_pos(1,:) = [0,0];
    x = (0:N);
    r = sqrt((fm+((x*lambda)/4)).*lambda.*(x));
   
    for i=1:N/2
        y_pos(4*i-3,:) = [r(2*i-1),h_zone];
%         y_pos_str(4*i-3,:) = [strjoin({'r' num2str(r(2*i-1))},''),num2str(h_zone)];
        y_pos(4*i-2,:) = [r(2*i),h_zone];
%         y_pos_str(4*i-2,:) = [strjoin({'r' num2str(r(2*i))},''),num2str(h_zone)];
        y_pos(4*i-1,:) = [r(2*i),0];
%         y_pos_str(4*i-1,:) = [strjoin({'r' num2str(r(2*i))},''),num2str(h_zone)];
        y_pos(4*i,:) =  [r(2*i+1),0];
%         y_pos_str(4*i,:) = [strjoin({'r' num2str(r(2*i+1))},''),num2str(h_zone)];
    end
        y_pos_offset = [y_pos;0 0];
%         y_pos_offset_str = [y_pos_str;0 0];
    
    
%      figure;
%      plot(y_pos_offset(:,1),y_pos_offset(:,2));
%      grid on;
%      ylim([-0.0500 2]);
    
    if mode(m/2,2)==0
        incident_ex = 2+ 2*[1:m/4];
    else
        incident_ex = 2+ 2*[1:(m/2+1)/2];
    end
%Minimum cut-width

    d = diff(r);
    min_cut = min(nonzeros(d));
    
end