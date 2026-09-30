$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: stepped spacer, 18 mm long, bore 3.2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 8;       // points of the closed outline

profile = [[1.6, 0], [6.6, 0], [6.6, 6.3], [4.95, 6.3], [4.95, 11.7], [3.63, 11.7], [3.63, 18], [1.6, 18]];  // single closed polygon, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
