$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: flanged spacer, 40 mm long, bore 3.2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 6;       // points of the closed outline

profile = [[1.6, 0], [13.6, 0], [13.6, 3], [5.6, 3], [5.6, 40], [1.6, 40]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
