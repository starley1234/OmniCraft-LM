$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 10 and 14 mm, 65 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 60.417], [1.847, 6.962], [2.802, 4.023], [5.302, 2.206], [71.115, 0], [75.347, 0.899], [78.242, 4.114], [78.694, 8.417], [76.531, 12.164], [10.347, 65.024], [6.115, 65.923], [2.163, 64.164]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
