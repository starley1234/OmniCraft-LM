$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: stepped spacer, 40 mm long, bore 5.2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 8;       // points of the closed outline

profile = [[2.6, 0], [5.6, 0], [5.6, 16], [4.2, 16], [4.2, 28], [3.08, 28], [3.08, 40], [2.6, 40]];  // single closed polygon, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
