$fn = 32;

// ----------------------------------------------------------------------
// Form washer: countersunk washer, 13.5 mm outside, 6.5 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 6;       // points of the closed outline

profile = [[3.25, 0], [5.75, 0], [6.75, 1], [6.75, 6], [5.05, 6], [3.25, 4.2]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
