$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 12 and 12 mm, 75 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 11;      // points of the closed outline

profile = [[0, 5.967], [1.146, 2.44], [4.146, 0.261], [80.373, 0], [84, 0.771], [86.481, 3.527], [86.869, 7.215], [85.015, 10.426], [81.627, 11.934], [4.146, 11.673], [1.146, 9.494]];  // single closed polygon, 11 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
