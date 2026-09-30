$fn = 32;

// ----------------------------------------------------------------------
// Form washer: chamfered washer, 21.2 mm outside, 5.2 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 7;       // points of the closed outline

profile = [[2.6, 0], [8.6, 0], [10.6, 2], [10.6, 6], [8.6, 8], [4.6, 8], [2.6, 6]];  // single closed polygon, 7 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
