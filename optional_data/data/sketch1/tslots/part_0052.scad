$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 70 x 42 mm section, 100 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 100;     // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [70, 0], [70, 15], [63, 15], [63, 10], [53, 10], [53, 32], [63, 32], [63, 27], [70, 27], [70, 42], [0, 42], [0, 27], [7, 27], [7, 32], [17, 32], [17, 10], [7, 10], [7, 15], [0, 15]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
