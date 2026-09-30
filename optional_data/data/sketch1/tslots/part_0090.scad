$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 80 x 30 mm section, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 80;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[0, 0], [80, 0], [80, 10], [75, 10], [75, 7], [65, 7], [65, 23], [75, 23], [75, 20], [80, 20], [80, 30], [0, 30], [0, 20], [5, 20], [5, 23], [15, 23], [15, 7], [5, 7], [5, 10], [0, 10]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
