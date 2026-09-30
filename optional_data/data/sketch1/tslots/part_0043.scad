$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 40 x 36 mm section, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 100;     // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [40, 0], [40, 10], [34, 10], [34, 7], [24, 7], [24, 29], [34, 29], [34, 26], [40, 26], [40, 36], [0, 36]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
