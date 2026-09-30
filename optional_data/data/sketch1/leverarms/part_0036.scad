$fn = 32;

// ----------------------------------------------------------------------
// Lever arm: two bosses 12 and 14 mm, 45 mm between centres
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 44.417], [0.847, 6.962], [1.993, 3.435], [4.993, 1.255], [51.115, 0], [55.347, 0.899], [58.242, 4.114], [58.694, 8.417], [56.531, 12.164], [10.347, 49.024], [6.115, 49.923], [2.163, 48.164]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
