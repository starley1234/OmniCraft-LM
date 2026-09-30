$fn = 32;

// ----------------------------------------------------------------------
// Form washer: chamfered washer, 13.5 mm outside, 3.5 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 7;       // points of the closed outline

profile = [[1.75, 0], [5.25, 0], [6.75, 1.5], [6.75, 3.5], [5.25, 5], [3.25, 5], [1.75, 3.5]];  // single closed polygon, 7 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
