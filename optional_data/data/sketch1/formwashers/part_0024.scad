$fn = 32;

// ----------------------------------------------------------------------
// Form washer: countersunk washer, 18.2 mm outside, 5.2 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 6;       // points of the closed outline

profile = [[2.6, 0], [8.1, 0], [9.1, 1], [9.1, 12], [7.4, 12], [2.6, 7.2]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
