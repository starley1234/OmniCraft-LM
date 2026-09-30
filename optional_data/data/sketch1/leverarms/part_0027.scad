$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 16 and 12 mm, 75 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 7.608], [1.528, 2.906], [5.528, 0], [10.472, 0], [82.373, 1.641], [86, 2.412], [88.481, 5.168], [88.869, 8.856], [87.015, 12.067], [11, 72.805], [7.373, 73.576], [3.985, 72.067], [2.131, 68.856]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
