$fn = 32;

// ----------------------------------------------------------------------
// Form washer: stepped_c washer, 16.5 mm outside, 6.5 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 6;       // points of the closed outline

profile = [[3.25, 0], [8.25, 0], [8.25, 6], [5.75, 6], [5.75, 9], [3.25, 9]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
