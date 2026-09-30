$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: spool spacer, 18 mm long, bore 4.4 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 8;       // points of the closed outline

profile = [[2.2, 0], [5.2, 0], [5.2, 2.16], [4.2, 2.16], [4.2, 15.84], [5.2, 15.84], [5.2, 18], [2.2, 18]];  // single closed polygon, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
