$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 80 x 42 mm section, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 80;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [80, 0], [80, 16], [75, 16], [75, 11], [57, 11], [57, 31], [75, 31], [75, 26], [80, 26], [80, 42], [0, 42]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
