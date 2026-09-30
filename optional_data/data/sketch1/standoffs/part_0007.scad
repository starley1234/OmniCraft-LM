$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: stepped spacer, 30 mm long, bore 4.4 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 8;       // points of the closed outline

profile = [[2.2, 0], [6.2, 0], [6.2, 9], [4.65, 9], [4.65, 18], [3.41, 18], [3.41, 30], [2.2, 30]];  // single closed polygon, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
