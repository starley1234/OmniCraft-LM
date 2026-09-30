$fn = 32;

// ----------------------------------------------------------------------
// Form washer: countersunk washer, 17.5 mm outside, 4.5 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 6;       // points of the closed outline

profile = [[2.25, 0], [7.75, 0], [8.75, 1], [8.75, 10], [7.05, 10], [2.25, 5.2]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
