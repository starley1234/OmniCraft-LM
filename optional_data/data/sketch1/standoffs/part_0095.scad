$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: spool spacer, 24 mm long, bore 3.2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 8;       // points of the closed outline

profile = [[1.6, 0], [4.6, 0], [4.6, 3.84], [3.6, 3.84], [3.6, 20.16], [4.6, 20.16], [4.6, 24], [1.6, 24]];  // single closed polygon, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
