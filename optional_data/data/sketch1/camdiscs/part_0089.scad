$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 11.0 mm, lift 6.0 mm, 20 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[28, 12.513], [27.567, 15.946], [26.533, 19.439], [24.734, 23.157], [21.587, 26.63], [17, 28.73], [11.781, 28.576], [7.008, 26.266], [3.247, 22.505], [0.832, 17.766], [0, 12.513], [0.937, 7.294], [3.88, 2.981], [8.276, 0.505], [12.934, 0], [17, 0.73], [20.433, 1.946], [23.466, 3.614], [25.899, 6.048], [27.462, 9.114]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
