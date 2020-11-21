% Controller & Observer Gains
wc = 50;
w0 = 40;
b0 = 140;
a0 = 0; 
a1 = 7.6;

% Initializing Transfer Function Constants
% For Gc(s)
Cn0 = ((wc^2)*(w0^3));
Cn1 = ((3*(wc^2)*(w0^2)) + (2*(wc)*(w0^3)));
Cn2 = ((3*(wc^2)*(w0)) + (6*wc*(w0^2)) +(w0^3)); 

Cd0 = ((wc^2)+(3*(w0^2))+(6*wc*w0));
Cd1 = ((2*wc) + (3*w0));
Cd2 = 1; 

% For H(s)
Hn0 = (w0^3);
Hn1 = (3*(w0^2));
Hn2 = (3*w0);
Hn3 = 1;

Hd0 = Cn0;
Hd1 = Cn1;
Hd2 = Cn2;

% Evaluating Transfer Functions
s = tf('s');

% Plant Transfer Function
Gp = 142.94/(s^2+(a1*s)+a0);

% Controller Transfer Function
Gc = ((1/(b0*s))*(((Cn2*s^2)+(Cn1*s)+Cn0)/((Cd2*s^2)+(Cd1*s)+Cd0)));

% H(s)
H = ((wc^2))*((Hn3*s^3)+(Hn2*s^2)+(Hn1*s)+Hn0)/((Hd2*s^2)+(Hd1*s)+Hd0);

% Closed-loop Transfer Function
Gyr = (H*Gc*Gp)/(1+(Gc*Gp));

% Loop Gain Transfer Function
Glp = Gp*Gc;

% Disturbance-to-Output Transfer Function
Gyd = Gp/(1+(Gc*Gp));

% % Bode Plots
% bode(Glp)
% hold on
% 
% % Getting Gain and Phase Margins
% [Gm, Pm, Wcg, Wcp] = margin(Glp);
% 
% %Gain Margin in dB
% GmdB = 20*log10(Gm);
% Pm;
% 
% % Create title
% title('Bode Diagram','HitTest','off','Units','pixels',...
%     'HorizontalAlignment','center',...
%     'FontWeight','normal',...
%     'FontSize',11);