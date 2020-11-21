% Initializing Arrays

% Array of a0 values
a0V = [0,0.1,1,10];

% Array of a1 values
a1V = [0,0.1,1,10];

% Magic FOR Loop
for i = a0V
    for j = a1V
    createBodePlot(i,j);
    %To skip the value a1 = 0, redefine a1V
    a1V = [0.1, 1, 10];
    end
end

function Gp = createBodePlot(a0, a1)
    wc = 50;
    w0 = 40;
    b0 = 140;
 
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
      
    % Bode Plots
    [mag, phase, wout] = bode(Glp);
    
    %Plotting the Bode Plot as a sum of SubPlots
    
    % Create title (ALWAYS USE sgtitle for subplot titles and not title)
    sgtitle('Bode Diagram','FontWeight','normal','FontSize',11);
    
    %SUBPLOTS
    %Random Line Style
    linS = {'-','--',':','-.'}'; %Indexing the line types
    
    %Getting a random line style from the linS array
    idx = randperm(length(linS),1);
    l = linS(idx);
    
    %Setting the LineStyle Property as an array
    NameArray = {'LineStyle'};
    
    %Plotting the subplot
    figure(1)
    
    %Setting Legend
    lgdstr = ['a0 = ', num2str(a0),';',' a1 = ', num2str(a1)]; %For the legend, num2str is for including a variable name
    leg = legend('show');
    title(leg, 'a0 and a1');
    
    %Starting Subplot
    subplot(2,1,1);
    %Gain Plot
    P = semilogx(wout, 20*log10(squeeze(mag)),'LineWidth',1, 'Color', rand(1,3), 'DisplayName', lgdstr);
    %Setting the line style property for P
    set(P,NameArray,l); 
    hold on %For all Gain Plots to be displayed on one plot
    %No grids
    grid off
    set(gca, 'xticklabel', []); %Removing the xtick labels in the Gain plot.
    ylabel('Magnitude (dB)','FontWeight','normal','FontSize',10);
    
    subplot(2,1,2);
    %Phase Plot
    Q = semilogx(wout, squeeze(phase),'LineWidth',1, 'Color', rand(1,3), 'DisplayName', lgdstr);
    %Setting the line style property for Q
    set(Q,NameArray,l);
    xlabel('Frequency (rad/s)','FontWeight','normal','FontSize',10);
    ylabel('Phase (deg)','FontWeight','normal','FontSize',10);
    hold on  
end
