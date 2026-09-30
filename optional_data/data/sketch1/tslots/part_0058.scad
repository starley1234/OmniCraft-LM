$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 80 x 42 mm section, 120 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 120;     // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [80, 0], [80, 13], [75, 13], [75, 8], [61, 8], [61, 34], [75, 34], [75, 29], [80, 29], [80, 42], [0, 42]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
