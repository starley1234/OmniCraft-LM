$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: collar, 14 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 6;       // points of the closed outline

profile = [[6, 0], [15, 0], [15, 4], [10, 4], [10, 14], [6, 14]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
