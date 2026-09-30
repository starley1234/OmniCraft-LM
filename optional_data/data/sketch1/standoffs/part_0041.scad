$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: stepped spacer, 30 mm long, bore 4 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 8;       // points of the closed outline

profile = [[2, 0], [7, 0], [7, 9], [5.25, 9], [5.25, 18], [3.85, 18], [3.85, 30], [2, 30]];  // single closed polygon, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
