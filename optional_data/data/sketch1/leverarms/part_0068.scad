$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 12 and 14 mm, 75 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 5;       // extrusion height
profile_points = 13;      // points of the closed outline

profile = [[0, 6.962], [1.146, 3.435], [4.146, 1.255], [80.268, 0], [126.627, 0.995], [130.015, 2.503], [131.869, 5.714], [131.481, 9.402], [129, 12.158], [125.373, 12.929], [81.732, 13.923], [4.146, 12.668], [1.146, 10.488]];  // single closed polygon, 13 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
