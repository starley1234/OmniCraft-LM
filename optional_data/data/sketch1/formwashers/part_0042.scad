$fn = 32;

// ----------------------------------------------------------------------
// Form washer: countersunk washer, 12.2 mm outside, 5.2 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 6;       // points of the closed outline

profile = [[2.6, 0], [5.1, 0], [6.1, 1], [6.1, 6], [4.4, 6], [2.6, 4.2]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
