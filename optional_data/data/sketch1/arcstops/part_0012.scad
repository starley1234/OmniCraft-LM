$fn = 32;

// ----------------------------------------------------------------------
// Arc stop: collar, 10 mm thick
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 6;       // points of the closed outline

profile = [[4, 0], [13, 0], [13, 5], [8, 5], [8, 10], [4, 10]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
