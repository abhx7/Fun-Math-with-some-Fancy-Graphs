# KP-II Equation Solver in MATLAB

This repository provides a MATLAB script to solve the **Kadomtsev–Petviashvili II (KP-II)** equation, a partial differential equation that models long waves with weak transverse effects. The code uses a spectral method for efficient computation and includes real-time 3D visualization.

## Equation

The KP-II equation in two dimensions is given by:
\[
(u_t + 6 u u_x + u_{xxx})_x - 3 u_{yy} = 0
\]
where:
- \( u \) is the wave amplitude,
- \( x \) and \( y \) are spatial dimensions, and
- \( t \) is time.

## Solution Method

This solver applies a **pseudo-spectral method** for efficient computation in Fourier space.

### Step-by-Step Method

1. **Spatial Discretization**  
   The domain in \( x \) and \( y \) is discretized into a grid with `Nx` and `Ny` points over lengths `Lx` and `Ly` respectively. **Fast Fourier Transform (FFT)** is used to convert spatial derivatives into multiplications in Fourier space.

2. **Initial Condition**  
   A simple **sech-based initial condition** is used to represent an initial wave packet:
   ```matlab
   u = sech(sqrt(X.^2 + Y.^2));

Fourier Transforms and Wavenumbers

Define Fourier wavenumbers 
𝑘
𝑥
k 
x
​
  and 
𝑘
𝑦
k 
y
​
  based on Lx, Ly, Nx, and Ny.
Generate a 2D wavenumber grid using:
matlab
Copy code
KX = (2*pi/Lx) * [0:(Nx/2-1), -Nx/2:-1];
KY = (2*pi/Ly) * [0:(Ny/2-1), -Ny/2:-1];
Calculate the wavenumber square K_sq for use in the update step.
Time-Stepping Loop
Using a pseudo-spectral method:

Compute the nonlinear term in the equation in physical space, transform to Fourier space, and update the solution.
Apply Inverse Fourier Transform (IFFT) to bring the updated wave profile back to physical space.
Real-time Visualization
The script updates a 3D surface plot after each time step using MATLAB’s surf function:

matlab
Copy code
set(h, 'ZData', u); % Update the plot with new data
drawnow;            % Render the updated plot in real-time
Full Code
Refer to kp_ii_solver.m for the complete implementation of the above method.

Parameters
Lx, Ly: Domain lengths in x and y directions.
Nx, Ny: Number of grid points in x and y directions.
dt: Time step size.
T: Total simulation time.
Running the Code
To run the code:

Open kp_ii_solver.m in MATLAB.
Adjust parameters as needed.
Run the script to simulate the KP-II wave equation and visualize results in real-time.
