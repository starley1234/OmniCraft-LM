$fn = 32;

// ----------------------------------------------------------------------
// Form washer: stepped_c washer, 19.5 mm outside, 3.5 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 6;       // points of the closed outline

profile = [[1.75, 0], [9.75, 0], [9.75, 8], [5.25, 8], [5.25, 12], [1.75, 12]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
