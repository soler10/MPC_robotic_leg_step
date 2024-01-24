<h1>Model Predictive Control (MPC) of the optimal step of a robotic dog</h1>
<h3>Model Predictive Control (MPC) is an advanced control strategy used in engineering. It optimally predicts future system behavior, considers constraints, and iteratively adjusts control inputs to achieve desired performance.</h3>
<h2> To study the step of a dog: execute model_passa_gos.mlx </h2>

<h4>Simulation with MPC:</h4>

In the following documents some terrain profiles are created, to change the terrain, comment the one active and uncomment the desired terrain profile to be tested

0) MPC with intial constraints and objective function
  - MPC_bnb_fmincon_0_no_changes.mlx

1) MPC with intial objective function and constraints modifyed
  - MPC_bnb_fmincon_1_constraint_added.mlx

2) MPC with intial constraints and objective function changed
  - MPC_bnb_fmincon_2_obj_func_change

The results of the steps on both modifications and terrains are saved on the Performance.mlx file 
