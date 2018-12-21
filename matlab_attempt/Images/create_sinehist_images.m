% These are images for summary statistics and will just have random data
clear
close all

%Printer type
format_type = '-dpng';
resolution = '-r100';

% Image size
font_size = 12;
im_size = 400;

% Constants
num_boot = 5000;
mu_bimodal = [6*pi/8 11*pi/8];
kappa_bimodal = [2 4];
weights_bimodal = [2 0.75];


% von_mises pdf function
vm_pdf = @(X,mu,kappa) exp(kappa.*cos(X-mu))./(2*pi*besseli(0,kappa));
bimodal = @(X) weights_bimodal(1)*vm_pdf(X,mu_bimodal(1),kappa_bimodal(1)) + ...
               weights_bimodal(2)*vm_pdf(X,mu_bimodal(2),kappa_bimodal(2));

bimodal_max = 1.2;


%Plot the different distributions (Note the bimodal is not a true pdf since
%it is unnormalized) This doesn't matter for the sampling.
figure(1)
dtheta = 2*pi/100;
theta = 0:dtheta:2*pi;
actual_pdf = bimodal(theta);
plot(theta,actual_pdf/(sum(actual_pdf)*dtheta),'LineWidth',2); 
title('Density function')
xlabel('x');
ylabel('f(x)')
set(gca,'FontSize',font_size,'box','off','XLim',[0 2*pi])  
set(gcf,'Position',[400 400 400 300]);
           


%Do rejection sampling for bimodal distribution
count = 1;
bimodal_samples = zeros(num_boot,1);

while count<=num_boot
    potential_angle = rand*2*pi;
    potential_value = rand*bimodal_max;
    if potential_value < bimodal(potential_angle)
        bimodal_samples(count) = potential_angle;
        count = count+1;
    end
end


%Plot histogram
figure;
dbin = 2*pi/40;
theta = 0:dbin:2*pi;
counts = hist(bimodal_samples,theta);
actual_pdf = bimodal(theta);
bar(theta,counts/(sum(counts)*dbin),1); hold on;
plot(theta,actual_pdf/(sum(actual_pdf)*dbin),'r');
title('Histogram of bimodal samples');


%Now the two plots to show in the question
figure(2)
hist(bimodal_samples,10);
title('Histogram with 10 bins')
set(gca,'FontSize',font_size,'box','off','XLim',[0 2*pi])  
set(gcf,'Position',[400 400 400 300]);

figure(3)
hist(bimodal_samples,30);
title('Histogram with 30 bins')
set(gca,'FontSize',font_size,'box','off','XLim',[0 2*pi])  
set(gcf,'Position',[400 400 400 300]);

% Print all 3

print(1,'Cropped\vm_pdf',format_type,resolution);
print(2,'Cropped\vm_hist10',format_type,resolution);
print(3,'Cropped\vm_hist30',format_type,resolution);





