$fn = 32;

// ----------------------------------------------------------------------
// Form washer: domed washer, 18.2 mm outside, 5.2 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 7;       // points of the closed outline

profile = [[2.6, 0], [9.1, 0], [9.1, 5], [7.475, 5], [5.85, 8.18], [4.22, 5], [2.6, 5]];  // single closed polygon, 7 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
