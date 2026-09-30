$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 14 and 10 mm, 65 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 6.657], [1.337, 2.543], [4.837, 0], [9.163, 0], [71.477, 1.685], [74.5, 2.327], [76.568, 4.624], [76.891, 7.697], [75.346, 10.373], [9.5, 62.988], [6.477, 63.63], [3.654, 62.373], [2.109, 59.697]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
