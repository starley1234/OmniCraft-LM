$fn = 32;

// ----------------------------------------------------------------------
// Form washer: chamfered washer, 17.5 mm outside, 4.5 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 7;       // points of the closed outline

profile = [[2.25, 0], [6.8, 0], [8.75, 1.95], [8.75, 6.05], [6.8, 8], [4.2, 8], [2.25, 6.05]];  // single closed polygon, 7 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
