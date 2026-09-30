$fn = 32;

// ----------------------------------------------------------------------
// Key bar: parallel key, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 11;      // points of the closed outline

profile = [[0, 6.962], [1.337, 2.847], [4.837, 0.304], [32.268, 0], [36.5, 0.899], [39.395, 4.114], [39.847, 8.417], [37.684, 12.164], [33.732, 13.923], [4.837, 13.619], [1.337, 11.076]];  // single closed polygon, 11 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
