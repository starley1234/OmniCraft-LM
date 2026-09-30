$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: stepped spacer, 18 mm long, bore 6.5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 8;       // points of the closed outline

profile = [[3.25, 0], [7.25, 0], [7.25, 5.4], [5.44, 5.4], [5.44, 10.8], [3.99, 10.8], [3.99, 18], [3.25, 18]];  // single closed polygon, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
