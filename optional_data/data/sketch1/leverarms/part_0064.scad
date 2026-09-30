$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 10 and 12 mm, 55 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 51.215], [0.869, 5.967], [1.824, 3.028], [4.324, 1.212], [60.242, 0], [63.869, 0.771], [66.35, 3.527], [66.738, 7.215], [64.884, 10.426], [8.869, 55.163], [5.242, 55.934], [1.854, 54.426]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
