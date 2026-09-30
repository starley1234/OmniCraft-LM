$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 210 mm bar with 3 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [206, 0], [208.828, 1.172], [210, 4], [210, 40], [170.25, 40], [170.25, 35], [173.25, 35], [173.25, 14], [141.75, 14], [141.75, 35], [144.75, 35], [144.75, 40], [117.75, 40], [117.75, 35], [120.75, 35], [120.75, 14], [89.25, 14], [89.25, 35], [92.25, 35], [92.25, 40], [65.25, 40], [65.25, 35], [68.25, 35], [68.25, 14], [36.75, 14], [36.75, 35], [39.75, 35], [39.75, 40], [0, 40]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
