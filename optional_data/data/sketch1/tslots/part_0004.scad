$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 40 x 42 mm section, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 100;     // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [40, 0], [40, 15], [34, 15], [34, 11], [16, 11], [16, 31], [34, 31], [34, 27], [40, 27], [40, 42], [0, 42]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
