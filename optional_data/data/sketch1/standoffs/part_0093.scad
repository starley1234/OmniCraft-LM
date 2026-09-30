$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: conical spacer, 24 mm long, bore 6.5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 6;       // points of the closed outline

profile = [[3.25, 0], [11.25, 0], [11.25, 4], [8.25, 4], [4.75, 24], [3.25, 24]];  // single closed polygon, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
