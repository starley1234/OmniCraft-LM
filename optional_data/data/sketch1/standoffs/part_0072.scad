$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: spool spacer, 40 mm long, bore 4.4 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 8;       // points of the closed outline

profile = [[2.2, 0], [7.2, 0], [7.2, 6.4], [4.2, 6.4], [4.2, 33.6], [7.2, 33.6], [7.2, 40], [2.2, 40]];  // single closed polygon, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
