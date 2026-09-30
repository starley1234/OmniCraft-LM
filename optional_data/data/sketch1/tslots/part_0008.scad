$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 40 x 24 mm section, 60 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 60;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [40, 0], [40, 4], [34, 4], [34, 3], [24, 3], [24, 21], [34, 21], [34, 20], [40, 20], [40, 24], [0, 24], [0, 20], [6, 20], [6, 21], [16, 21], [16, 3], [6, 3], [6, 4], [0, 4]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
