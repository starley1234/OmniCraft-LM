$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: spool spacer, 24 mm long, bore 4.4 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 8;       // points of the closed outline

profile = [[2.2, 0], [6.2, 0], [6.2, 4.8], [4.2, 4.8], [4.2, 19.2], [6.2, 19.2], [6.2, 24], [2.2, 24]];  // single closed polygon, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
