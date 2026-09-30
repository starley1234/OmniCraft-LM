$fn = 32;

// ----------------------------------------------------------------------
// Form washer: countersunk washer, 15.5 mm outside, 8.5 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 6;       // points of the closed outline

profile = [[4.25, 0], [6.75, 0], [7.75, 1], [7.75, 10], [6.05, 10], [4.25, 8.2]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
