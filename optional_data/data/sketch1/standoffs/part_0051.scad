$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: conical spacer, 18 mm long, bore 3.2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 6;       // points of the closed outline

profile = [[1.6, 0], [11.6, 0], [11.6, 4], [8.6, 4], [4.1, 18], [1.6, 18]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
