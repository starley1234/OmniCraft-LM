$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: conical spacer, 18 mm long, bore 5.2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 6;       // points of the closed outline

profile = [[2.6, 0], [12.6, 0], [12.6, 4], [7.6, 4], [5.1, 18], [2.6, 18]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
