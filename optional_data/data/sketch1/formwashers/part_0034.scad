$fn = 32;

// ----------------------------------------------------------------------
// Form washer: chamfered washer, 18.5 mm outside, 8.5 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 7;       // points of the closed outline

profile = [[4.25, 0], [7.75, 0], [9.25, 1.5], [9.25, 10.5], [7.75, 12], [5.75, 12], [4.25, 10.5]];  // single closed polygon, 7 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
