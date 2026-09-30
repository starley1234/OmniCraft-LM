$fn = 32;

// ----------------------------------------------------------------------
// Form washer: domed washer, 13.5 mm outside, 6.5 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 7;       // points of the closed outline

profile = [[3.25, 0], [6.75, 0], [6.75, 12], [5.875, 12], [5, 16.2], [4.12, 12], [3.25, 12]];  // single closed polygon, 7 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
