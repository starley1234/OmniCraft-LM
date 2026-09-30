$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 80 x 24 mm section, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 80;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [80, 0], [80, 4], [73, 4], [73, 3], [63, 3], [63, 21], [73, 21], [73, 20], [80, 20], [80, 24], [0, 24], [0, 20], [7, 20], [7, 21], [17, 21], [17, 3], [7, 3], [7, 4], [0, 4]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
