$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 210 mm bar with 3 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 32;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [206, 0], [208.828, 1.172], [210, 4], [210, 40], [170.25, 40], [170.25, 37], [173.25, 37], [173.25, 10], [141.75, 10], [141.75, 37], [144.75, 37], [144.75, 40], [117.75, 40], [117.75, 37], [120.75, 37], [120.75, 10], [89.25, 10], [89.25, 37], [92.25, 37], [92.25, 40], [65.25, 40], [65.25, 37], [68.25, 37], [68.25, 10], [36.75, 10], [36.75, 37], [39.75, 37], [39.75, 40], [0, 40]];  // single closed polygon, 32 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
