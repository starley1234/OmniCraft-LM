$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 210 mm bar with 2 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [206, 0], [208.828, 1.172], [210, 4], [210, 50], [163, 50], [163, 47], [168, 47], [168, 24], [112, 24], [112, 47], [117, 47], [117, 50], [93, 50], [93, 47], [98, 47], [98, 24], [42, 24], [42, 47], [47, 47], [47, 50], [0, 50]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
