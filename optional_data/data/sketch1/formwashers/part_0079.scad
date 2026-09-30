$fn = 32;

// ----------------------------------------------------------------------
// Form washer: domed washer, 10.5 mm outside, 3.5 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 7;       // points of the closed outline

profile = [[1.75, 0], [5.25, 0], [5.25, 12], [4.375, 12], [3.5, 16.2], [2.62, 12], [1.75, 12]];  // single closed polygon, 7 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
