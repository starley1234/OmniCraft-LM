$fn = 32;

// ----------------------------------------------------------------------
// Form washer: chamfered washer, 16.5 mm outside, 3.5 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 7;       // points of the closed outline

profile = [[1.75, 0], [6.3, 0], [8.25, 1.95], [8.25, 10.05], [6.3, 12], [3.7, 12], [1.75, 10.05]];  // single closed polygon, 7 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
