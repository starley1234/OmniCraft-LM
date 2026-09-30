$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 80 x 30 mm section, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 80;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [80, 0], [80, 10], [75, 10], [75, 5], [57, 5], [57, 25], [75, 25], [75, 20], [80, 20], [80, 30], [0, 30]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
