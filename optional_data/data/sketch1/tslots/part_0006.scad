$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 70 x 30 mm section, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 80;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [70, 0], [70, 8], [63, 8], [63, 4], [53, 4], [53, 26], [63, 26], [63, 22], [70, 22], [70, 30], [0, 30], [0, 22], [7, 22], [7, 26], [17, 26], [17, 4], [7, 4], [7, 8], [0, 8]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
