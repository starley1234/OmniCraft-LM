$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 80 x 24 mm section, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 80;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [80, 0], [80, 7], [73, 7], [73, 4], [55, 4], [55, 20], [73, 20], [73, 17], [80, 17], [80, 24], [0, 24], [0, 17], [7, 17], [7, 20], [25, 20], [25, 4], [7, 4], [7, 7], [0, 7]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
