$fn = 32;

// ----------------------------------------------------------------------
// Form washer: chamfered washer, 12.2 mm outside, 5.2 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 7;       // points of the closed outline

profile = [[2.6, 0], [5.05, 0], [6.1, 1.05], [6.1, 10.95], [5.05, 12], [3.65, 12], [2.6, 10.95]];  // single closed polygon, 7 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
