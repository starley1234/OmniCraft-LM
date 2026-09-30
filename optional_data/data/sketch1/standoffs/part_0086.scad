$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: stepped spacer, 40 mm long, bore 3.2 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 8;       // points of the closed outline

profile = [[1.6, 0], [8.6, 0], [8.6, 16], [6.45, 16], [6.45, 28], [4.73, 28], [4.73, 40], [1.6, 40]];  // single closed polygon, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
