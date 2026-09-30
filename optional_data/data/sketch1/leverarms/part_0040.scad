$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 10 and 12 mm, 45 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 43.215], [0.869, 5.967], [1.824, 3.028], [4.324, 1.212], [50.242, 0], [53.869, 0.771], [56.35, 3.527], [56.738, 7.215], [54.884, 10.426], [8.869, 47.163], [5.242, 47.934], [1.854, 46.426]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
