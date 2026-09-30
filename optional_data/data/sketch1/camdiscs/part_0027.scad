$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 11.0 mm, lift 10.0 mm, 22 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 22;      // points of the closed outline

profile = [[32, 14.2], [31.688, 17.338], [31.102, 20.693], [30.089, 24.689], [27.907, 29.325], [24.026, 35.243], [17.75, 36.807], [12.198, 33.475], [7.248, 30.071], [3.334, 25.554], [0.851, 20.117], [0, 14.2], [0.984, 8.323], [4.182, 3.392], [9.133, 0.505], [14.515, 0], [19.118, 1.112], [22.657, 2.676], [25.59, 4.15], [28.203, 5.887], [30.254, 8.253], [31.554, 11.101]];  // single closed polygon, 22 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
