$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: flanged spacer, 24 mm long, bore 5.2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 6;       // points of the closed outline

profile = [[2.6, 0], [9.6, 0], [9.6, 4], [5.6, 4], [5.6, 24], [2.6, 24]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
