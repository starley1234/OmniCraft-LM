$fn = 32;

// ----------------------------------------------------------------------
// Form washer: domed washer, 19.5 mm outside, 6.5 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 7;       // points of the closed outline

profile = [[3.25, 0], [9.75, 0], [9.75, 5], [8.125, 5], [6.5, 9.09], [4.88, 5], [3.25, 5]];  // single closed polygon, 7 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
