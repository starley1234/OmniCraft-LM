$fn = 32;

// ----------------------------------------------------------------------
// Form washer: countersunk washer, 19.5 mm outside, 3.5 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 6;       // points of the closed outline

profile = [[1.75, 0], [8.75, 0], [9.75, 1], [9.75, 12], [8.05, 12], [1.75, 5.7]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
