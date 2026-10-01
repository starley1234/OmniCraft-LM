$fn = 32;

// ----------------------------------------------------------------------
// Revolved part: V-groove pulley R25
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 6;               // bore radius
rim_r = 25;               // rim radius
rim_t = 14;               // rim width
groove_r = 16;            // groove root radius
groove_w = 4;             // groove half width
revolve_angle = 360;      // revolve sweep, degrees

bore_d = 2 * bore_r;
rim_d = 2 * rim_r;
groove_d = 2 * groove_r;

profile = [[6, 0], [25, 0], [25, 3], [16, 7], [25, 11], [25, 14], [6, 14]];  // primary outline, 7 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
