$fn = 32;

// ----------------------------------------------------------------------
// Form washer: domed washer, 19.5 mm outside, 3.5 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 7;       // points of the closed outline

profile = [[1.75, 0], [9.75, 0], [9.75, 10], [7.75, 10], [5.75, 13.5], [3.75, 10], [1.75, 10]];  // single closed polygon, 7 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
