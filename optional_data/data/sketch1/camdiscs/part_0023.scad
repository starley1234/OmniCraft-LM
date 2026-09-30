$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 11.0 mm, lift 4.0 mm, 20 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[26, 13], [25.555, 16.429], [24.208, 19.69], [21.95, 22.566], [18.826, 24.776], [15, 26], [10.792, 25.952], [6.668, 24.468], [3.174, 21.592], [0.827, 17.605], [0, 13], [0.827, 8.395], [3.174, 4.408], [6.668, 1.532], [10.792, 0.048], [15, 0], [18.826, 1.224], [21.95, 3.434], [24.208, 6.31], [25.555, 9.571]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
