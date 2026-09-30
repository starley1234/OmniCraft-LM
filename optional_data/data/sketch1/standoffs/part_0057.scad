$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: stepped spacer, 55 mm long, bore 5.2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 8;       // points of the closed outline

profile = [[2.6, 0], [9.6, 0], [9.6, 16.5], [7.2, 16.5], [7.2, 33], [5.28, 33], [5.28, 55], [2.6, 55]];  // single closed polygon, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
