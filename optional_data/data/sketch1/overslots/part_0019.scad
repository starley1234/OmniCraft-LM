$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 180 mm bar with 2 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [176, 0], [178.828, 1.172], [180, 4], [180, 60], [137, 60], [137, 55], [141, 55], [141, 30], [99, 30], [99, 55], [103, 55], [103, 60], [77, 60], [77, 55], [81, 55], [81, 30], [39, 30], [39, 55], [43, 55], [43, 60], [0, 60]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
