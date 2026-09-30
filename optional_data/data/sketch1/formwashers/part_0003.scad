$fn = 32;

// ----------------------------------------------------------------------
// Form washer: stepped_c washer, 12.2 mm outside, 5.2 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 6;       // points of the closed outline

profile = [[2.6, 0], [6.1, 0], [6.1, 5], [5.1, 5], [5.1, 8], [2.6, 8]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
