$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: flanged spacer, 18 mm long, bore 3.2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 6;       // points of the closed outline

profile = [[1.6, 0], [9.6, 0], [9.6, 5], [5.6, 5], [5.6, 18], [1.6, 18]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
