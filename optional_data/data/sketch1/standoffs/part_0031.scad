$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: conical spacer, 55 mm long, bore 5.2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 6;       // points of the closed outline

profile = [[2.6, 0], [10.6, 0], [10.6, 3], [7.6, 3], [4.1, 55], [2.6, 55]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
