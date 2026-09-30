$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: stepped spacer, 24 mm long, bore 6.5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 8;       // points of the closed outline

profile = [[3.25, 0], [10.25, 0], [10.25, 9.6], [7.69, 9.6], [7.69, 16.8], [5.64, 16.8], [5.64, 24], [3.25, 24]];  // single closed polygon, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
