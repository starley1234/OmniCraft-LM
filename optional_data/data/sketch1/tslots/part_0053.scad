$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 40 x 24 mm section, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 60;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [40, 0], [40, 6], [34, 6], [34, 3], [24, 3], [24, 21], [34, 21], [34, 18], [40, 18], [40, 24], [0, 24], [0, 18], [6, 18], [6, 21], [16, 21], [16, 3], [6, 3], [6, 6], [0, 6]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
