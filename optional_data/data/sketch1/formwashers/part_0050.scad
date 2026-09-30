$fn = 32;

// ----------------------------------------------------------------------
// Form washer: chamfered washer, 16.5 mm outside, 6.5 mm bore
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 7;       // points of the closed outline

profile = [[3.25, 0], [6.75, 0], [8.25, 1.5], [8.25, 4.5], [6.75, 6], [4.75, 6], [3.25, 4.5]];  // single closed polygon, 7 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
