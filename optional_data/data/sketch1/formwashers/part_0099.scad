$fn = 32;

// ----------------------------------------------------------------------
// Form washer: countersunk washer, 16.5 mm outside, 6.5 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 6;       // points of the closed outline

profile = [[3.25, 0], [7.25, 0], [8.25, 1], [8.25, 8], [6.55, 8], [3.25, 4.7]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
