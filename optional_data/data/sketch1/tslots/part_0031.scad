$fn = 32;

// ----------------------------------------------------------------------
// T-slot rail: 60 x 24 mm section, 80 mm long
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 80;      // extrusion height
profile_points = 12;      // points of the closed outline

profile = [[0, 0], [60, 0], [60, 7], [55, 7], [55, 4], [45, 4], [45, 20], [55, 20], [55, 17], [60, 17], [60, 24], [0, 24]];  // single closed polygon, 12 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
