$fn = 32;

// ----------------------------------------------------------------------
// Form washer: domed washer, 16.5 mm outside, 3.5 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 7;       // points of the closed outline

profile = [[1.75, 0], [8.25, 0], [8.25, 6], [6.625, 6], [5, 8.5], [3.38, 6], [1.75, 6]];  // single closed polygon, 7 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
