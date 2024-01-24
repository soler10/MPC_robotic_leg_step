function signal=step_generator(T, A)
dx=6;

% Set the time interval and step sizes
t = 0:dx:T-1;
step1 = A;
step2 = 0;

% Create the periodic signal
period = T; % period in seconds
freq = 1/period; % frequency in Hz
signal = (square(2*pi*freq*t, 50) + 1)/2; % square wave with duty cycle of 50%
signal(signal == 1) = step1; % set all "1" values to the first step size
signal(signal == 0) = step2; % set all "0" values to the second step size
end
