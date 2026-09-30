$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 70 x 42 mm section, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 100;     // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [70, 0], [70, 15], [63, 15], [63, 12], [53, 12], [53, 30], [63, 30], [63, 27], [70, 27], [70, 42], [0, 42], [0, 27], [7, 27], [7, 30], [17, 30], [17, 12], [7, 12], [7, 15], [0, 15]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
