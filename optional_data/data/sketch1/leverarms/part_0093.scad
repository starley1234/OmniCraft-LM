$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 16 and 12 mm, 55 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 7.608], [1.528, 2.906], [5.528, 0], [10.472, 0], [96.627, 1.641], [100.015, 3.15], [101.869, 6.361], [101.481, 10.049], [99, 12.805], [95.373, 13.576], [10.472, 15.217], [5.528, 15.217], [1.528, 12.311]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
