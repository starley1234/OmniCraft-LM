$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: conical spacer, 40 mm long, bore 4.4 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 6;       // points of the closed outline

profile = [[2.2, 0], [12.2, 0], [12.2, 3], [9.2, 3], [4.7, 40], [2.2, 40]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
