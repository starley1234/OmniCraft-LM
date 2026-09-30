$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 70 x 55 mm, 1 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 16;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [67, 0], [69.121, 0.879], [70, 3], [70, 55], [41, 55], [41, 51], [45.85, 51], [45.85, 25], [24.15, 25], [24.15, 51], [29, 51], [29, 55], [0, 55]];  // single closed polygon, 16 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
