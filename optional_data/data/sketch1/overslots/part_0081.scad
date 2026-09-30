$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 210 mm bar with 2 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 8;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [206, 0], [208.828, 1.172], [210, 4], [210, 60], [163, 60], [163, 55], [168, 55], [168, 30], [112, 30], [112, 55], [117, 55], [117, 60], [93, 60], [93, 55], [98, 55], [98, 30], [42, 30], [42, 55], [47, 55], [47, 60], [0, 60]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
