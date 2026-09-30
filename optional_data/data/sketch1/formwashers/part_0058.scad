$fn = 32;

// ----------------------------------------------------------------------
// Form washer: stepped_c washer, 21.5 mm outside, 8.5 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 6;       // points of the closed outline

profile = [[4.25, 0], [10.75, 0], [10.75, 8], [6.75, 8], [6.75, 13], [4.25, 13]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
