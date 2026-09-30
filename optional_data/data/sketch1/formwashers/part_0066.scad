$fn = 32;

// ----------------------------------------------------------------------
// Form washer: stepped_c washer, 18.5 mm outside, 8.5 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 6;       // points of the closed outline

profile = [[4.25, 0], [9.25, 0], [9.25, 5], [7.75, 5], [7.75, 10], [4.25, 10]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
