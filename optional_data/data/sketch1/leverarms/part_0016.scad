$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 12 and 14 mm, 75 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 11;      // points of the closed outline

profile = [[0, 6.962], [1.146, 3.435], [4.146, 1.255], [80.268, 0], [84.5, 0.899], [87.395, 4.114], [87.847, 8.417], [85.684, 12.164], [81.732, 13.923], [4.146, 12.668], [1.146, 10.488]];  // single closed polygon, 11 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
