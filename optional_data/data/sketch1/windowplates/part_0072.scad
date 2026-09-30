$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 90 x 45 mm, 1 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [87, 0], [89.121, 0.879], [90, 3], [90, 45], [58.95, 45], [58.95, 19], [31.05, 19], [31.05, 45], [0, 45]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
