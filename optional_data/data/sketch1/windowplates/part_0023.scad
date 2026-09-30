$fn = 32;

// ----------------------------------------------------------------------
// Window plate: 130 x 45 mm, 1 open windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 16;      // points of the closed outline

profile = [[0, 3], [0.879, 0.879], [3, 0], [127, 0], [129.121, 0.879], [130, 3], [130, 45], [69, 45], [69, 41], [85.15, 41], [85.15, 27], [44.85, 27], [44.85, 41], [61, 41], [61, 45], [0, 45]];  // single closed polygon, 16 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
