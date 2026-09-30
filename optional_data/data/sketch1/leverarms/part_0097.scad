$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 12 and 12 mm, 45 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 11;      // points of the closed outline

profile = [[0, 5.967], [1.146, 2.44], [4.146, 0.261], [50.373, 0], [54, 0.771], [56.481, 3.527], [56.869, 7.215], [55.015, 10.426], [51.627, 11.934], [4.146, 11.673], [1.146, 9.494]];  // single closed polygon, 11 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
