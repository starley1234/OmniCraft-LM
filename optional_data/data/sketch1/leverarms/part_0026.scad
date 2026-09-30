$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 16 and 8 mm, 55 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 7.608], [1.528, 2.906], [5.528, 0], [10.472, 0], [62.582, 3.63], [65, 4.144], [66.654, 5.982], [66.913, 8.44], [65.677, 10.581], [63.418, 11.587], [10.472, 15.217], [5.528, 15.217], [1.528, 12.311]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
