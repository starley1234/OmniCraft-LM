$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: conical spacer, 24 mm long, bore 4.4 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 6;       // points of the closed outline

profile = [[2.2, 0], [8.2, 0], [8.2, 3], [5.2, 3], [3.7, 24], [2.2, 24]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
