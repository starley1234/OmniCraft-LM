$fn = 32;

// ----------------------------------------------------------------------
// Profiled standoff: spool spacer, 55 mm long, bore 6.5 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
revolve_angle = 360;      // full turn around the Z axis
profile_points = 8;       // points of the closed outline

profile = [[3.25, 0], [8.25, 0], [8.25, 8.8], [5.25, 8.8], [5.25, 46.2], [8.25, 46.2], [8.25, 55], [3.25, 55]];  // single closed polygon, 8 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
