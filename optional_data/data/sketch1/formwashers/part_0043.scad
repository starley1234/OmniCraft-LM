$fn = 32;

// ----------------------------------------------------------------------
// Form washer: domed washer, 24.5 mm outside, 8.5 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 7;       // points of the closed outline

profile = [[4.25, 0], [12.25, 0], [12.25, 8], [10.25, 8], [8.25, 13.04], [6.25, 8], [4.25, 8]];  // single closed polygon, 7 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
