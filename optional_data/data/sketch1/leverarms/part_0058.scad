$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 16 and 12 mm, 65 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 7.608], [1.528, 2.906], [5.528, 0], [10.472, 0], [72.373, 1.641], [76, 2.412], [78.481, 5.168], [78.869, 8.856], [77.015, 12.067], [73.627, 13.576], [10.472, 15.217], [5.528, 15.217], [1.528, 12.311]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
