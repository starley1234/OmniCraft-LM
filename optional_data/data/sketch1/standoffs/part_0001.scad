$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: flanged spacer, 18 mm long, bore 4 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 6;       // points of the closed outline

profile = [[2, 0], [11, 0], [11, 3], [5, 3], [5, 18], [2, 18]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
