$fn = 32;

// ----------------------------------------------------------------------
// Form washer: domed washer, 11.5 mm outside, 4.5 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 7;       // points of the closed outline

profile = [[2.25, 0], [5.75, 0], [5.75, 6], [4.875, 6], [4, 8.21], [3.12, 6], [2.25, 6]];  // single closed polygon, 7 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
