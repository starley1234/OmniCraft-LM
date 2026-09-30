$fn = 32;

// ----------------------------------------------------------------------
// Form washer: chamfered washer, 18.2 mm outside, 5.2 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 7;       // points of the closed outline

profile = [[2.6, 0], [7.15, 0], [9.1, 1.95], [9.1, 8.05], [7.15, 10], [4.55, 10], [2.6, 8.05]];  // single closed polygon, 7 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
