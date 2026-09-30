$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: spool spacer, 40 mm long, bore 4.4 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 8;       // points of the closed outline

profile = [[2.2, 0], [7.2, 0], [7.2, 4.8], [3.7, 4.8], [3.7, 35.2], [7.2, 35.2], [7.2, 40], [2.2, 40]];  // single closed polygon, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
