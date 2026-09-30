$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 60 x 24 mm section, 120 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 120;     // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [60, 0], [60, 6], [53, 6], [53, 3], [43, 3], [43, 21], [53, 21], [53, 18], [60, 18], [60, 24], [0, 24], [0, 18], [7, 18], [7, 21], [17, 21], [17, 3], [7, 3], [7, 6], [0, 6]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
