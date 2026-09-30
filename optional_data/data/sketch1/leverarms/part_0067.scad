$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 14 and 14 mm, 55 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 11;      // points of the closed outline

profile = [[0, 6.962], [1.337, 2.847], [4.837, 0.304], [61.268, 0], [65.5, 0.899], [68.395, 4.114], [68.847, 8.417], [66.684, 12.164], [62.732, 13.923], [4.837, 13.619], [1.337, 11.076]];  // single closed polygon, 11 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
