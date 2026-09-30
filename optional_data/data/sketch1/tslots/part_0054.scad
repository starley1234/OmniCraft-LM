$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 70 x 36 mm section, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 100;     // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [70, 0], [70, 10], [64, 10], [64, 5], [50, 5], [50, 31], [64, 31], [64, 26], [70, 26], [70, 36], [0, 36], [0, 26], [6, 26], [6, 31], [20, 31], [20, 5], [6, 5], [6, 10], [0, 10]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
