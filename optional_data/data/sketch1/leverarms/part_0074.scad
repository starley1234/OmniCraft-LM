$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 14 and 10 mm, 75 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 6.657], [1.337, 2.543], [4.837, 0], [9.163, 0], [81.477, 1.685], [84.5, 2.327], [86.568, 4.624], [86.891, 7.697], [85.346, 10.373], [9.5, 55.988], [6.477, 56.63], [3.654, 55.373], [2.109, 52.697]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
