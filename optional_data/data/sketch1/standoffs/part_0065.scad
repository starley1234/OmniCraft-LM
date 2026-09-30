$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: spool spacer, 55 mm long, bore 4 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 8;       // points of the closed outline

profile = [[2, 0], [9, 0], [9, 8.8], [4, 8.8], [4, 46.2], [9, 46.2], [9, 55], [2, 55]];  // single closed polygon, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
