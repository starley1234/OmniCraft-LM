$fn = 32;

// ----------------------------------------------------------------------
// Form washer: countersunk washer, 16.5 mm outside, 3.5 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 6;       // points of the closed outline

profile = [[1.75, 0], [7.25, 0], [8.25, 1], [8.25, 12], [6.55, 12], [1.75, 7.2]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
