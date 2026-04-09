% -----------------------------------------------------
%
% ASEN 2501: Introduction to Astronautics
% Module 4: Space Environment and Communications
%
% Lab 1: The LEO Space Environment
%
% Part 1: Plotting MSIS Profiles
%
% -----------------------------------------------------

clear; close all; clc

%% Load the first profiles from your downloaded MSIS files

% This function parses the data in the file into the appropriate columns.
% Having a separate function makes it easy to repeat  on more files
% (as you'll see later)

function plotAtmosphereProfiles(data1)
%% Q3.1: Mass density plot
figure; % new window
ax1 = axes;

semilogx(ax1, data1.density.mass, data1.altkm, 'LineWidth', 2);
xlabel(ax1, 'Mass density (g/cm^3)');
ylabel(ax1, 'Altitude (km)');
title(ax1, sprintf('Mass density for %s', datetime(data1.time)));

set(ax1, 'FontSize', 14);

%% Q3.2: Number densities
figure; % new window
ax2 = axes;

semilogx(ax2, data1.density.O,  data1.altkm, 'LineWidth', 1.5); hold(ax2,'on');
semilogx(ax2, data1.density.N2, data1.altkm, 'LineWidth', 1.5);
semilogx(ax2, data1.density.O2, data1.altkm, 'LineWidth', 1.5);
semilogx(ax2, data1.density.Ar, data1.altkm, 'LineWidth', 1.5);
semilogx(ax2, data1.density.He, data1.altkm, 'LineWidth', 1.5);
semilogx(ax2, data1.density.H,  data1.altkm, 'LineWidth', 1.5);
semilogx(ax2, data1.density.N,  data1.altkm, 'LineWidth', 1.5);

set(ax2, 'XScale', 'log');
xlim(ax2, [1e0 1e20]);

legend(ax2, 'Oxygen 1','Nitrogen 2','Oxygen 2','Argon','Helium','Hydrogen','Nitrogen 1');
xlabel(ax2, 'Number density (#/cm^3)');
ylabel(ax2, 'Altitude (km)');
title(ax2, sprintf('Number density for %s', datetime(data1.time)));

set(ax2, 'FontSize', 14);

%% Q3.3: Temperature profile
figure; % new window
ax3 = axes;

plot(ax3, data1.tempK, data1.altkm, 'LineWidth', 1.5);
xlabel(ax3, 'Temperature (K)');
ylabel(ax3, 'Altitude (km)');
title(ax3, sprintf('Temperature vs Altitude for %s', datetime(data1.time)));

set(ax3, 'FontSize', 14);

end


data1 = parseMSISdata('MSISprofiles/MSIS-01022020-1200-lat40.txt');

plotAtmosphereProfiles(data1);



% data2: same date, but midnight 
data2 = parseMSISdata('MSISprofiles/MSIS-01022020-0000-lat40.txt');
%plotAtmosphereProfiles(data2);

figure; % new window
ax3 = axes;

plot(ax3, data1.tempK, data1.altkm, 'LineWidth', 1.5);
hold on;
plot(ax3, data2.tempK, data2.altkm, 'LineWidth', 1.5);
legend(ax3, "Afternoon", "Midnight");
xlabel(ax3, 'Temperature (K)');
ylabel(ax3, 'Altitude (km)');
title(ax3, sprintf('Temperature vs Altitude Comparison'));

set(ax3, 'FontSize', 14);

% data3: same date and time, 0 latitude
data3 = parseMSISdata('MSISprofiles/MSIS-01022020-1200-lat00.txt');

% data4: same date and time, 80 latitude
data4 = parseMSISdata('MSISprofiles/MSIS-01022020-1200-lat80.txt');

%plotAtmosphereProfiles(data3);
%plotAtmosphereProfiles(data4);

%% Latitude comparison

figure; % new window
axLatComp = axes;

plot(axLatComp, data1.tempK, data1.altkm, 'LineWidth', 1.5);
hold on;
plot(axLatComp, data3.tempK, data3.altkm, 'LineWidth', 1.5);
plot(axLatComp, data4.tempK, data4.altkm, 'LineWidth', 1.5);
legend(axLatComp, "40 Lat.", "0 Lat.", "80 Lat.");
xlabel(axLatComp, 'Temperature (K)');
ylabel(axLatComp, 'Altitude (km)');
title(axLatComp, sprintf('Temperature vs Latitude Comparison'));
xlim(axLatComp, [125, 850]);

set(axLatComp, 'FontSize', 14);

% data5: same time and lat, July 2022 
data5 = parseMSISdata('MSISprofiles/MSIS-07052022-1200-lat40.txt');


%% day/night comparison: data1 and data2. Learn subplots!

h4 = figure(4);
set(h4,'position',[800 600 1400 500]);      % wider!
ax41 = subplot(1,3,1);          % creates the first in a 1 x 3 array of panels 
ax42 = subplot(1,3,2);
ax43 = subplot(1,3,3);

% MASS DENSITY: plot data1 and data2 mass density to compare.

semilogx(ax41,data1.density.mass,data1.altkm,'linewidth',1.5);
hold(ax41,'on');
semilogx(ax41,data2.density.mass,data2.altkm,'linewidth',1.5);

legend(ax41,'Noon','Midnight');

% label your plots! 

xlabel(ax41, "Mass Density (g/cm^3)");
ylabel(ax41, "Altitude (km)");
title(ax41, "Mass Density vs Altitude (Day/Night Comparison)");

% change the font size
set(ax41,'Fontsize',14);

% NUMBER DENSITY: just do N2, O, and He for both data1 and data2.

semilogx(ax42,data1.density.N2,data1.altkm,'linewidth',1.5);
hold(ax42,'on');
semilogx(ax42,data2.density.N2,data2.altkm,'linewidth',1.5);

semilogx(ax42,data1.density.O,data1.altkm,'linewidth',1.5);
semilogx(ax42,data2.density.O,data2.altkm,'linewidth',1.5);

semilogx(ax42,data1.density.He,data1.altkm,'linewidth',1.5);
semilogx(ax42,data2.density.He,data2.altkm,'linewidth',1.5);

legend(ax42,'N2 Noon','N2 Midnight','O Noon','O Midnight','He Noon','He Midnight');

xlim(ax42, [1e0, 10e20]);

% label your plots! 

xlabel(ax42, "Number Density (#/cm^3)");
ylabel(ax42, "Altitude (km)");
title(ax42, "Number Density vs Altitude (Day/Night Comparison)");


% change the font size

set(ax42,'Fontsize',14);

% TEMPERATURE: plot tempK for both data1 and data2

plot(ax43,data1.tempK,data1.altkm,'linewidth',1.5);
hold(ax43,'on');
plot(ax43,data2.tempK,data2.altkm,'linewidth',1.5);

legend(ax43,'Noon','Midnight');

% label your plots! 

xlabel(ax43, "Temperature (K)");
ylabel(ax43, "Altitude (km)");
title(ax43, "Temperature vs Altitude (Day/Night Comparison)");


% change the font size

set(ax43,'Fontsize',14);


%% latitude comparison: data1, data3, data4

h5 = figure(5);
set(h5,'position',[800 600 1400 500]);      % wider!
ax51 = subplot(1,3,1);          % creates the first in a 1 x 3 array of panels 
ax52 = subplot(1,3,2);
ax53 = subplot(1,3,3);

% MASS DENSITY: plot for data1, data3, and data4

semilogx(ax51,data1.density.mass,data1.altkm,'linewidth',1.5);
hold(ax51,'on');
semilogx(ax51,data3.density.mass,data3.altkm,'linewidth',1.5);
semilogx(ax51,data4.density.mass,data4.altkm,'linewidth',1.5);

legend(ax51,'40 deg','0 deg','80 deg');

% label your plots! 

xlabel(ax51, "Mass Density (g/cm^3)");
ylabel(ax51, "Altitude (km)");
title(ax51, "Mass Density vs Altitude (Latitude Comparison)");

% change the font size

set(ax51,'Fontsize',14);

% NUMBER DENSITY: just do N2, O, and He for data1, data3, and data4

semilogx(ax52,data1.density.N2,data1.altkm,'linewidth',1.5);
hold(ax52,'on');
semilogx(ax52,data3.density.N2,data3.altkm,'linewidth',1.5);
semilogx(ax52,data4.density.N2,data4.altkm,'linewidth',1.5);

semilogx(ax52,data1.density.O,data1.altkm,'linewidth',1.5);
semilogx(ax52,data3.density.O,data3.altkm,'linewidth',1.5);
semilogx(ax52,data4.density.O,data4.altkm,'linewidth',1.5);

semilogx(ax52,data1.density.He,data1.altkm,'linewidth',1.5);
semilogx(ax52,data3.density.He,data3.altkm,'linewidth',1.5);
semilogx(ax52,data4.density.He,data4.altkm,'linewidth',1.5);

legend(ax52,'N2 40 deg','N2 0 deg','N2 80 deg','O 40 deg','O 0 deg','O 80 deg',...
    'He 40 deg','He 0 deg','He 80 deg');

% label your plots! 

xlabel(ax52, "Number Density (#/cm^3)");
ylabel(ax52, "Altitude (km)");
title(ax52, "Number Density vs Altitude (Latitude Comparison)");

set(ax52,'xlim',[1e0 1e20]);

% change the font size

set(ax52,'Fontsize',14);

% TEMPERATURE: for data1, data3, and data4

plot(ax53,data1.tempK,data1.altkm,'linewidth',1.5);
hold(ax53,'on');
plot(ax53,data3.tempK,data3.altkm,'linewidth',1.5);
plot(ax53,data4.tempK,data4.altkm,'linewidth',1.5);

legend(ax53,'40 deg','0 deg','80 deg');

% label your plots! 

xlabel(ax53, "Temperature (K)");
ylabel(ax53, "Altitude (km)");
title(ax53, "Temperature vs Altitude (Latitude Comparison)");

% change the font size

set(ax53,'Fontsize',14);


%% summer / winter comparison: data1 and data5

h6 = figure(6);
set(h6,'position',[800 600 1400 500]);      % wider!
ax61 = subplot(1,3,1);          % creates the first in a 1 x 3 array of panels 
ax62 = subplot(1,3,2);
ax63 = subplot(1,3,3);

% MASS DENSITY: for data1 and data5

semilogx(ax61,data1.density.mass,data1.altkm,'linewidth',1.5);
hold(ax61,'on');
semilogx(ax61,data5.density.mass,data5.altkm,'linewidth',1.5);

legend(ax61,'January 2020','July 2022');

% label your plots! 
xlabel(ax61, "Mass Density (g/cm^3)");
ylabel(ax61, "Altitude (km)");
title(ax61, "Mass Density vs Altitude (Season Comparison)");

% change the font size

set(ax61,'Fontsize',14);

% NUMBER DENSITY: just do N2, O, and He

semilogx(ax62,data1.density.N2,data1.altkm,'linewidth',1.5);
hold(ax62,'on');
semilogx(ax62,data5.density.N2,data5.altkm,'linewidth',1.5)

semilogx(ax62,data1.density.O,data1.altkm,'linewidth',1.5);
semilogx(ax62,data5.density.O,data5.altkm,'linewidth',1.5)

semilogx(ax62,data1.density.He,data1.altkm,'linewidth',1.5);
semilogx(ax62,data5.density.He,data5.altkm,'linewidth',1.5)

legend(ax62,'N2 Winter','N2 Summer','O Winter','O Summer',...
    'He Winter','He Summer');

% label your plots! 

xlabel(ax62, "Number Density (#/cm^3)");
ylabel(ax62, "Altitude (km)");
title(ax62, "Number Density vs Altitude (Season Comparison)");

set(ax62,'xlim',[1e0 1e20]);

% change the font size

set(ax62,'Fontsize',14);

% TEMPERATURE: plot for data1 and data5

plot(ax63,data1.tempK,data1.altkm,'linewidth',1.5);
hold(ax63,'on');
plot(ax63,data5.tempK,data5.altkm,'linewidth',1.5);

legend(ax63,'January 2020','July 2022');

% label your plots! 

xlabel(ax63, "Temperature (K)");
ylabel(ax63, "Altitude (km)");
title(ax63, "Temperature vs Altitude (Season Comparison)");

% change the font size

set(ax63,'Fontsize',14);

%% END
