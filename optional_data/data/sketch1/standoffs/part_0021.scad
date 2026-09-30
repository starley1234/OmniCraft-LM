$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: spool spacer, 24 mm long, bore 4.4 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 8;       // points of the closed outline

profile = [[2.2, 0], [7.2, 0], [7.2, 3.84], [3.7, 3.84], [3.7, 20.16], [7.2, 20.16], [7.2, 24], [2.2, 24]];  // single closed polygon, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
