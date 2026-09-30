$fn = 32;

// ----------------------------------------------------------------------
// Form washer: countersunk washer, 24.5 mm outside, 8.5 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 6;       // points of the closed outline

profile = [[4.25, 0], [11.25, 0], [12.25, 1], [12.25, 8], [9.05, 8], [4.25, 3.2]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
