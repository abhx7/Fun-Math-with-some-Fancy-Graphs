% KP-II equation solver using finite differences
% Parameters
Lx = 20;         % Length in x-direction
Ly = 20;         % Length in y-direction
Nx = 100;        % Number of grid points in x
Ny = 100;        % Number of grid points in y
T = 10;          % Total simulation time
dt = 0.01;       % Time step size
cfl = 0.1;       % CFL number for stability

dx = Lx / Nx;    % Spatial step in x
dy = Ly / Ny;    % Spatial step in y

% Discretize spatial domain
x = linspace(-Lx/2, Lx/2, Nx);
y = linspace(-Ly/2, Ly/2, Ny);
[X, Y] = meshgrid(x, y);

% Initialize solution: initial wave packet
u = sech(sqrt(X.^2 + Y.^2));

% Fourier transforms
kx = (2*pi/Lx) * [0:(Nx/2-1), -Nx/2:-1]; % Fourier wave numbers in x
ky = (2*pi/Ly) * [0:(Ny/2-1), -Ny/2:-1]; % Fourier wave numbers in y
[KX, KY] = meshgrid(kx, ky);
K_sq = KX.^2 + KY.^2;

% Time-stepping loop
for t = 0:dt:T
    % Fourier transform of current state
    u_hat = fft2(u);
    
    % Compute nonlinear term in physical space
    u_x = ifft2(1i * KX .* u_hat);
    nonlinear_term = 6 * u .* u_x;
    
    % Fourier transform of nonlinear term
    nonlinear_term_hat = fft2(nonlinear_term);
    
    % Update in Fourier space using pseudo-spectral method
    u_hat_new = (u_hat - dt * nonlinear_term_hat) ./ (1 + dt * K_sq);
    
    % Inverse Fourier transform to obtain new u in physical space
    u = real(ifft2(u_hat_new));
    
    % Plot the solution every few steps
    if mod(t, 0.5) < dt
        surf(x, y, u, 'EdgeColor', 'none');
        axis([-Lx/2, Lx/2, -Ly/2, Ly/2, -1, 1]);
        xlabel('x'); ylabel('y'); zlabel('u');
        title(sprintf('Time: %.2f', t));
        drawnow;
    end
end
