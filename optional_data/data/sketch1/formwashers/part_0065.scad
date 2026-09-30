$fn = 32;

// ----------------------------------------------------------------------
// Form washer: stepped_c washer, 11.5 mm outside, 4.5 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 6;       // points of the closed outline

profile = [[2.25, 0], [5.75, 0], [5.75, 6], [4.75, 6], [4.75, 10], [2.25, 10]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
