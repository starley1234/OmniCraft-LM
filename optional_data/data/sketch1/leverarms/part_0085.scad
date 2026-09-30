$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 14 and 14 mm, 55 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 6.962], [1.337, 2.847], [4.837, 0.304], [61.268, 0], [95.627, 0.995], [99.015, 2.503], [100.869, 5.714], [100.481, 9.402], [98, 12.158], [94.373, 12.929], [62.732, 13.923], [4.837, 13.619], [1.337, 11.076]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
