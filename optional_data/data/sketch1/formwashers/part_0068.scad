$fn = 32;

// ----------------------------------------------------------------------
// Form washer: chamfered washer, 14.5 mm outside, 4.5 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 7;       // points of the closed outline

profile = [[2.25, 0], [5.75, 0], [7.25, 1.5], [7.25, 10.5], [5.75, 12], [3.75, 12], [2.25, 10.5]];  // single closed polygon, 7 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
