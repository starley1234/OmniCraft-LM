$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 180 mm bar with 2 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [176, 0], [178.828, 1.172], [180, 4], [180, 40], [136, 40], [136, 37], [141, 37], [141, 14], [99, 14], [99, 37], [104, 37], [104, 40], [76, 40], [76, 37], [81, 37], [81, 14], [39, 14], [39, 37], [44, 37], [44, 40], [0, 40]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
