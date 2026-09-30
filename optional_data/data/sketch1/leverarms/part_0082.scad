$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 10 and 8 mm, 65 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 4.755], [0.955, 1.816], [3.455, 0], [6.545, 0], [69.582, 0.777], [72, 1.291], [73.654, 3.128], [73.913, 5.587], [72.677, 7.728], [7, 60.219], [4.582, 60.733], [2.323, 59.728], [1.087, 57.587]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
