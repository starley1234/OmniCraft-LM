$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: flanged spacer, 30 mm long, bore 4 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 6;       // points of the closed outline

profile = [[2, 0], [13, 0], [13, 5], [7, 5], [7, 30], [2, 30]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
