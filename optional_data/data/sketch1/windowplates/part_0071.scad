$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 130 x 55 mm, 1 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 16;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [127, 0], [129.121, 0.879], [130, 3], [130, 55], [69, 55], [69, 49], [85.15, 49], [85.15, 33], [44.85, 33], [44.85, 49], [61, 49], [61, 55], [0, 55]];  // single closed polygon, 16 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
