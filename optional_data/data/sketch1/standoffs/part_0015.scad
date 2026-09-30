$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: stepped spacer, 40 mm long, bore 6.5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 8;       // points of the closed outline

profile = [[3.25, 0], [6.25, 0], [6.25, 12], [4.69, 12], [4.69, 24], [3.44, 24], [3.44, 40], [3.25, 40]];  // single closed polygon, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
