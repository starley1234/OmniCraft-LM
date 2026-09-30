$fn = 32;

// ----------------------------------------------------------------------
// Form washer: domed washer, 15.2 mm outside, 5.2 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 7;       // points of the closed outline

profile = [[2.6, 0], [7.6, 0], [7.6, 5], [6.35, 5], [5.1, 7.45], [3.85, 5], [2.6, 5]];  // single closed polygon, 7 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
