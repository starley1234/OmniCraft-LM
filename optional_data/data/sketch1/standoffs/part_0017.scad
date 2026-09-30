$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: spool spacer, 18 mm long, bore 6.5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 8;       // points of the closed outline

profile = [[3.25, 0], [8.25, 0], [8.25, 2.16], [4.75, 2.16], [4.75, 15.84], [8.25, 15.84], [8.25, 18], [3.25, 18]];  // single closed polygon, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
