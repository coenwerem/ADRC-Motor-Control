% Initializing Arrays

% Array of a0 values
a0V = 0;

% Array of a1 values
a1V = [0.1, 1, 7.6, 10, 100];

% FOR Loop
for i = a0V
    for j = a1V
    createBodePlot(i,j);
    end
end

function Glp = createBodePlot(a0, a1)
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
    bode(Gyd);
    hold on 
        
    % Create title (ALWAYS USE sgtitle for subplot titles and not title)
    title('Bode Diagram','FontWeight','normal','FontSize',11);
    
    % Getting Gain and Phase Margins
    [Gm, Pm, Wcg, Wcp] = margin(Gyd);
    
    %Gain Margin in dB
    GmdB = 20*log10(Gm);
    
    %Table of Gain and Phase Margins
    T = table(GmdB, Pm);
         
end
