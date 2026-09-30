$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: stepped spacer, 24 mm long, bore 5.2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 8;       // points of the closed outline

profile = [[2.6, 0], [7.6, 0], [7.6, 8.4], [5.7, 8.4], [5.7, 15.6], [4.18, 15.6], [4.18, 24], [2.6, 24]];  // single closed polygon, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
