$fn = 32;

// ----------------------------------------------------------------------
// Form washer: chamfered washer, 10.5 mm outside, 3.5 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 7;       // points of the closed outline

profile = [[1.75, 0], [4.2, 0], [5.25, 1.05], [5.25, 3.95], [4.2, 5], [2.8, 5], [1.75, 3.95]];  // single closed polygon, 7 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
