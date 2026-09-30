$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 10 and 8 mm, 45 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 4.755], [0.955, 1.816], [3.455, 0], [6.545, 0], [49.582, 0.777], [52, 1.291], [53.654, 3.128], [53.913, 5.587], [52.677, 7.728], [50.418, 8.733], [6.545, 9.511], [3.455, 9.511], [0.955, 7.694]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
