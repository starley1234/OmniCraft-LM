$fn = 32;

// ----------------------------------------------------------------------
// Oversize slot bar: 180 mm bar with 2 oversize windows
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 6;       // extrusion height
profile_points = 24;      // points of the closed outline

profile = [[0, 4], [1.172, 1.172], [4, 0], [176, 0], [178.828, 1.172], [180, 4], [180, 60], [135, 60], [135, 57], [138, 57], [138, 30], [102, 30], [102, 57], [105, 57], [105, 60], [75, 60], [75, 57], [78, 57], [78, 30], [42, 30], [42, 57], [45, 57], [45, 60], [0, 60]];  // single closed polygon, 24 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
