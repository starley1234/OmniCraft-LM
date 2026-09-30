$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 130 x 35 mm, 1 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 12;      // extrusion height
profile_points = 16;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [127, 0], [129.121, 0.879], [130, 3], [130, 35], [71, 35], [71, 31], [85.15, 31], [85.15, 8], [44.85, 8], [44.85, 31], [59, 31], [59, 35], [0, 35]];  // single closed polygon, 16 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
