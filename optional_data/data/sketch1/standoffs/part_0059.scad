$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: spool spacer, 30 mm long, bore 5.2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 8;       // points of the closed outline

profile = [[2.6, 0], [9.6, 0], [9.6, 3.6], [4.1, 3.6], [4.1, 26.4], [9.6, 26.4], [9.6, 30], [2.6, 30]];  // single closed polygon, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
