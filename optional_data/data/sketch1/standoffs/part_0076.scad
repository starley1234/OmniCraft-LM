$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: stepped spacer, 30 mm long, bore 6.5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 8;       // points of the closed outline

profile = [[3.25, 0], [6.25, 0], [6.25, 9], [4.69, 9], [4.69, 18], [3.44, 18], [3.44, 30], [3.25, 30]];  // single closed polygon, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
