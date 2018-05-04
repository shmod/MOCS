% Self-propelled particle model of aggregation in two dimensions.
% Written by Kit Yates
% Added a weak force.

close all
clear all

%Set up movie
%fig=figure;
makemovie=1;

%movien = avifile('Vicsekmovie','FPS',3,'compression','none')

J=200; %Number of timestep t0 be used
UJ=1;   %Rate at which film is updated


t=1/J; %Size of one time step

N=40; %Number of particles

e=0.5; %e is eta the noise parameter, whose maximum value is 2*pi

r=1;
killr = 1;
%Force parameter
f = 0.6;

n = 4;
%The radius of influence of a particle

L=50; %L is the size of the domain on which the particles can move

v=0.5; %v is the speed at which the particles move

% x(i,j) gives the x coordinate of the ith particle at time j
x=zeros(N,J+1);
x(:,1)=L*rand(N,1); %define initial x coordiantes of all particles

% y(i,j) gives the y coordinate of the ith particle at time j
y=zeros(N,J+1);
y(:,1)=L*rand(N,1); %define initial y coordiantes of all particles

% T(i,j) gives the angle with the x axis of the direction of motion of the ith
% particle at time j
T=zeros(N,J+1);
T(:,1)=2*pi*rand(N,1); %define initial direction of all particles

%Hunter particle
H = zeros(1, J+1);
H(1) = 2*pi*rand(1,1);
Hx = zeros(1, J+1);
Hy = zeros(1, J+1);
Hx(1) = L*rand(1,1);
Hy(1) = L*rand(1,1);

predatormode = 10;

i = 1;
j = 1;
%For all time steps
for j=1:J
    masscenter = [nanmean(x(:,j)) nanmean(y(:,j))];
    masscentersx = zeros(1,8);
    masscentersy = zeros(1,8);
    inP = zeros(1,8);
    perimeter = zeros(1, 8);
    %For each particle
    for i=1:N
        %finds how many particles are in the interaction radius of each
        %particle
        if (isnan(x(i,j)))
            x(i,j+1) = NaN;
            y(i,j+1) = NaN;
        else
            
            %If a predator is really close!
            distpredx = Hx(j)-x(i,j);
            distpredy = Hy(j)-y(i,j);
            totDist = (distpredx^2+distpredy^2)^0.5;
            if (totDist < 8)
                angleAway = atan2(distpredy, distpredx) + pi;
                T(i,j+1) = angleAway + 0.1*(rand-0.5);
            else
                if (i < 21)
                    n = 4;
                else
                    n = 14;
                end
                %find the n closest particles
                dist = ((x(i,j)-x(:,j)).^2+(y(i,j)-y(:,j)).^2).^0.5;
                %dist(i) = 1000;
                B = zeros(N,1);
                indx = zeros(n,1);
                val = zeros(n,1);
                for k = 1:n
                    [val(i), indx(k)] = min(dist);
                    dist(indx(k)) = 10000;
                end
                B(indx) = 1;
                ss=sum(sin(T(:,j)).*B)/sum(B);
                sc=sum(cos(T(:,j)).*B)/sum(B);
                S=atan2(ss,sc);
                
                dist2 = [(masscenter(1)-x(i,j)) (masscenter(2)-y(i,j))];
                angleCent = atan2((dist2(2)),(dist2(1)));
            T(i,j+1) = atan2(sin(angleCent)*f + sin(S) , cos(angleCent)*f+cos(S)) + e*(rand-0.5);
            end
            
            
            x(i,j+1)=x(i,j)+v*cos(T(i,j+1)); %updates the particles' x-coordinates
            y(i,j+1)=y(i,j)+v*sin(T(i,j+1)); %updates the particles' y coordinates
            
            % Jumps from the right of the box to the left or vice versa
            %x(i,j+1)=mod(x(i,j+1),L);
            
            %Jumps from the top of the box to the bottom or vice versa
            % y(i,j+1)=mod(y(i,j+1),L);
            
            %Plot particles
            
            if makemovie
                if abs(x(i,j)-x(i,j+1))<v & abs(y(i,j)-y(i,j+1))<v
                    plot([x(i,j), x(i,j+1)] ,[y(i,j),y(i,j+1)],'k-','markersize',4) %plots the first half of the particles in black
                    axis([0 L 0 L]);
                    hold on
                    plot(x(i,j+1) ,y(i,j+1),'k.','markersize',10)
                    xlabel('X position')
                    ylabel('Y position')
                end
            end
        end
    end
    
    %For the predator particle
    %The predator particle has a circular perimeter that can be devided into 8 pieces
    %It calculates the distance to all particles and puts them in their
    %respective areas. It then assigns them a value that is scaled to their
    %distance to the predator. The close a prey is to the predator, the
    %higher this value. It sums up all these values and moves towards the
    %weighted masscenter of this perimeter. If a particle is within a
    %really close distance, it will only move towards this particle.
    distX = x(:,j)-Hx(j);
    distY = y(:,j)-Hy(j);
    
    distP = ((distX).^2+(distY).^2).^0.5;
    anglesP = atan2(distY, distX);
    
    
    
    %For all particles accumulate the perimeter values
    for q = 1:length(distX)
        if (~isnan(distP(q)))
            if (anglesP(q) < 0)
                temp = anglesP(q);
                anglesP(q) = anglesP(q) + 2*pi;
            end
            k = ceil(anglesP(q)/(2*pi)*8);
            masscentersx(k) = masscentersx(k) + 1/distP(q)^2*abs(x(q,j));
            masscentersy(k) = masscentersy(k) + 1/distP(q)^2*abs(y(q,j));
            inP(k) = inP(k) + 1/distP(q)^2;
            perimeter(k) = perimeter(k) + 1/distP(q)^2;
        end
    end
    
    if (predatormode <= 0)
        predatormode = predatormode - 1;
        vpred = v;
    elseif (min(distP) < 10)
        if (predatormode == -10)
            predatormode = 10;
        elseif (predatormode > 0)
            predatormode = predatormode -1;
            vpred = v*3;
        end
    elseif (min(distP) < 20)    %If there is a particle closeby enhance speed
        vpred = v*1.4
    else
        vpred = v;
    end
    
    if (min(distP) < killr) %Eat the closest particle if dist < 3
        
        ind = find(min(distP) == distP)
        Hx(j+1) = x(ind,j+1);
        Hy(j+1) = y(ind,j+1);
        x(ind,j+1) = NaN;
        y(ind,j+1) = NaN;
    else %Otherwise move towards masscenters
        
        %Obtain the masscenters
        masscentersx = masscentersx./inP;
        masscentersy = masscentersy./inP;
        
        closestP = find(max(perimeter) == perimeter);
        masscenter = [masscentersx(closestP) masscentersy(closestP)];
        
        
        dist2 = [(masscenter(1)-Hx(j)) (masscenter(2)-Hy(j))];
        angleMassc = atan2((dist2(2)),(dist2(1)));
        
        H(j+1) = atan2(sin(angleMassc) , cos(angleMassc)) + 0.1*(rand-0.5);
        
        
        Hx(j+1)=Hx(j)+vpred*cos(H(j+1)); %updates the particles' x-coordinates
        Hy(j+1)=Hy(j)+vpred*sin(H(j+1)); %updates the particles' y coordinates
        plot(masscenter(1), masscenter(2), 'or');
        hold on
    end
    
    if makemovie
        plot([Hx(j), Hx(j+1)] ,[Hy(j),Hy(j+1)],'*b')
        axis([0 L 0 L]);
        hold on
        th = 0:pi/50:2*pi;
        xunit = 20 * cos(th) + Hx(j+1);
        yunit = 20 * sin(th) + Hy(j+1);
        l  = 0:0.5:20;
        plot(xunit, yunit ,'b-.');
        hold on
        for w = 1:8
            xunit = l*cos(2*pi/8*w) + Hx(j+1);
            yunit = l*sin(2*pi/8*w) + Hy(j+1);
            plot(xunit, yunit, 'b-.');
            hold on
        end
        xunit = killr * cos(th) + Hx(j+1);
        yunit = killr * sin(th) + Hy(j+1);
        plot(xunit, yunit, 'r-.');
        hold on
        %plot(Hx(j+1) ,Hy(j+1),'k.','markersize',10)
        xlabel('X position')
        ylabel('Y position')
    end
    
    if makemovie
        hold off
        M(j)=getframe; %makes a movie fram from the plot
        %movien = addframe(movien,M(j)); %adds this movie fram to the movie
    end
end
qe = 1/N*(sum(sin(T(:,end)))^2 + sum(cos(T(:,end)))^2)^0.5;
Mm = M;

%movien = close(movien); %finishes the movie

