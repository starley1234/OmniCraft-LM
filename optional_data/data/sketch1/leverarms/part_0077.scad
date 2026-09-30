$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 10 and 12 mm, 45 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 11;      // points of the closed outline

profile = [[0, 5.967], [0.955, 3.028], [3.455, 1.212], [49.373, 0], [53, 0.771], [55.481, 3.527], [55.869, 7.215], [54.015, 10.426], [50.627, 11.934], [3.455, 10.722], [0.955, 8.906]];  // single closed polygon, 11 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
